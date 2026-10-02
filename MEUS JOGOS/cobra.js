const cv=document.getElementById('cv'),ctx=cv.getContext('2d'),R=Math.random,W=4200;
let VW=0,VH=0,T=0,playing=false;
function resize(){const r=cv.parentElement.getBoundingClientRect();VW=cv.width=Math.max(200,r.width);VH=cv.height=Math.max(200,r.height)}
new ResizeObserver(resize).observe(cv.parentElement);resize();
const pal=[['#00e5ff','#a855f7'],['#ffd000','#ff7a00'],['#ff2a1a','#ff8c00'],['#9dff00','#22d36b'],['#ff3ea5','#ff9ad5'],['#00ffa6','#0077ff'],['#c084fc','#f0abfc'],['#ffffff','#7dd3fc'],['#fb7185','#fcd34d'],['#34d399','#a3e635'],['#f97316','#facc15'],['#38bdf8','#818cf8'],['#e879f9','#fb7185'],['#4ade80','#22d3ee'],['#fde047','#f43f5e'],['#a78bfa','#38bdf8'],['#f472b6','#c084fc'],['#2dd4bf','#a3e635'],['#fb923c','#f43f5e'],['#60a5fa','#34d399']];
const names=['SLITHER_KING','CHOMP_BOT','BLAZE_WORM','GREEN_MACHINE','NEON_VIPER','PIXEL_COIL','BYTE_ADDER','GLITCH_COBRA','TURBO_TAIL','ZIG_ZAG_ZED','LAVA_LOOP','FROST_FANG','VOID_VIPER','JADE_JAW','SOLAR_SERPENT','NOVA_NAGA','ROSE_RATTLER','MINT_MAMBA','EMBER_EEL','AQUA_ASP','COBALT_COIL','MAGMA_MAW','LUNAR_LASH','TOXIC_TAIL','PRISM_PYTHON','STATIC_SKINK','OMEGA_ORB','HYPER_HISS','CYBER_CORAL','RAZOR_RIBBON','PLASMA_PIT','ZEN_ZIGZAG','COMET_COIL','DELTA_DRAKE','FLUX_FANG','GAMMA_GLIDE','ION_IGUANA','KILO_KRAIT','LASER_LIZARD','MOSS_MOCCASIN'];
const N=40;
const hx=h=>{const a=.5,f=n=>{const k=(n+h/30)%12;return Math.round(255*(.6-a*.8*Math.max(-1,Math.min(k-3,9-k,1))))};return '#'+[0,8,4].map(n=>f(n).toString(16).padStart(2,'0')).join('')};
for(let i=0;i<20;i++)pal.push([hx(i*18+5),hx(i*18+70)]);
const rgb=h=>[1,3,5].map(i=>parseInt(h.substr(i,2),16));
const mix=(a,b,t)=>{const A=rgb(a),B=rgb(b);return `rgb(${A.map((x,i)=>Math.round(x+(B[i]-x)*t)).join()})`};
const fmt=n=>n.toLocaleString('pt-BR');
const da=a=>{while(a>Math.PI)a-=2*Math.PI;while(a<-Math.PI)a+=2*Math.PI;return a};
// cor de cada segmento conforme o padrão escolhido
function segCol(s,i,n){const p=s.pat||0;
 if(p===1)return Math.floor(i/3)%2?s.c[1]:s.c[0];
 if(p===2)return s.c[0];
 if(p===3)return `hsl(${(i*14)%360},95%,60%)`;
 return mix(s.c[0],s.c[1],i/n)}
// crescimento: espessura e comprimento aumentam sempre, mas de forma suave (sem limite)
const radOf=len=>7+1.1*Math.sqrt(len);
const wantOf=score=>16+Math.floor(Math.pow(score,.8)/12);
 
const cfg={name:'SLITHER_KING',c1:'#00e5ff',c2:'#a855f7',pat:0,crown:true};
try{const o=JSON.parse(localStorage.getItem('slither_cfg')||'{}');
 if(typeof o.name==='string')cfg.name=o.name.slice(0,14);
 if(/^#[0-9a-f]{6}$/i.test(o.c1))cfg.c1=o.c1;if(/^#[0-9a-f]{6}$/i.test(o.c2))cfg.c2=o.c2;
 if([0,1,2,3].includes(o.pat))cfg.pat=o.pat;if(typeof o.crown==='boolean')cfg.crown=o.crown}catch(e){}
const save=()=>{try{localStorage.setItem('slither_cfg',JSON.stringify(cfg))}catch(e){}};
 
const logEl=document.getElementById('log'),lines=[];
function log(c,tag,m){lines.push(`<div><span class="${c}">[${tag}]</span> ${m}</div>`);if(lines.length>5)lines.shift();logEl.innerHTML=lines.join('')}
let orbs=[],parts=[],snakes=[],mouse=0,cam={x:W/2,y:W/2,z:.7},leader='',boost=false;
const dead=document.getElementById('dead'),lb=document.getElementById('lb'),cust=document.getElementById('cust');
function orb(x,y,v,vx,vy){orbs.push({x,y,v:v||1,h:R()*360,r:4+(v||1)*1.8,vx:vx||0,vy:vy||0})}
function mk(id,x,y,ang,score){const s={id,name:names[id],c:pal[id],pat:0,ang,score,seg:[],alive:true,boost:false,rad:radOf(20)};for(let i=0;i<20;i++)s.seg.push({x:x-Math.cos(ang)*i*10,y:y-Math.sin(ang)*i*10});return s}
function start(){orbs=[];parts=[];snakes=[];
 for(let i=0;i<1800;i++)orb(R()*W,R()*W);
 const p=snakes[0]=mk(0,W/2,W/2,0,1200);
 p.name=cfg.name;p.c=[cfg.c1,cfg.c2];p.pat=cfg.pat;p.crown=cfg.crown;
 snakes[1]=mk(1,W/2+110,W/2-50,Math.PI,3000);
 for(let i=2;i<N;i++){const a=R()*6.28,d=250+R()*1000;snakes[i]=mk(i,W/2+Math.cos(a)*d,W/2+Math.sin(a)*d,R()*6.28,700+R()*3500)}
 T=0;leader='';cam={x:W/2,y:W/2,z:.7};dead.style.display='none';
 log('g','GAME','Arena iniciada com '+N+' cobras');
}
function die(s,k){if(!s.alive)return;s.alive=false;
 const n=s.seg.length;
 for(let i=0;i<n;i+=2){const p=s.seg[i],a=R()*6.28,v=1+R()*4;orb(p.x,p.y,2+Math.floor(R()*3),Math.cos(a)*v,Math.sin(a)*v)}
 parts.push({x:s.seg[0].x,y:s.seg[0].y,r:8,c:s.c[1],l:1});
 if(s.id===0){log('w','WARN',`Jogador ${s.name} eliminado${k?' por '+k.name:''}`);document.getElementById('fin').textContent='Pontuação final: '+fmt(Math.floor(s.score));dead.style.display='grid'}
 else{log('i','INFO',`Bot ${s.name} eliminated by ${k?(k.id===0?'PLAYER':k.name):'WALL'}`);const id=s.id;setTimeout(()=>{if(snakes[id]&&!snakes[id].alive&&T>0){const a=R()*6.28;snakes[id]=mk(id,W*.15+R()*W*.7,W*.15+R()*W*.7,a,700)}},3000)}
}
function ai(s){const h=s.seg[0];
 if(s.plan===undefined||T%3===s.id%3){
  const mine=s.score;let tx=null,ty=0,best=0,prey=null;const threats=[],near=[];
  for(const o of snakes){if(o===s||!o.alive)continue;const oh=o.seg[0],d=Math.hypot(oh.x-h.x,oh.y-h.y);
   if(d<560){near.push(o);if(o.score<mine*.8&&d<420&&(!prey||d<prey.d))prey={o,d};if(o.score>mine*1.1&&d<280)threats.push(o)}}
  for(const o of orbs){const d=Math.hypot(o.x-h.x,o.y-h.y);if(d<520){const sc=o.v*o.r/(d+40);if(sc>best){best=sc;tx=o.x;ty=o.y}}}
  let want=tx!==null?Math.atan2(ty-h.y,tx-h.x):s.ang+Math.sin(T/60+s.id)*.5;
  s.hunt=false;
  if(prey){const oh=prey.o.seg[0],lead=Math.min(100,prey.d*.4);want=Math.atan2(oh.y+Math.sin(prey.o.ang)*lead-h.y,oh.x+Math.cos(prey.o.ang)*lead-h.x);s.hunt=prey.d<280&&s.seg.length>24}
  let flee=null;
  if(threats.length){let ax=0,ay=0;for(const o of threats){ax+=h.x-o.seg[0].x;ay+=h.y-o.seg[0].y}flee=Math.atan2(ay,ax)}
  let bestA=s.ang,bs=-1e9;const k0=Math.max(1,s.rad/14);
  for(let k=-5;k<=5;k++){const a=s.ang+k*.3;let sc=-Math.abs(k)*.15+Math.cos(a-want)*2;
   if(flee!==null)sc+=Math.cos(a-flee)*3;
   for(const dd of[45,90,150]){const dist=dd*k0,px=h.x+Math.cos(a)*dist,py=h.y+Math.sin(a)*dist;
    if(px<100||px>W-100||py<100||py>W-100){sc-=14;break}
    let hit=false;
    for(let i=10;i<s.seg.length;i+=3){const p=s.seg[i];if((p.x-px)**2+(p.y-py)**2<(s.rad*1.7)**2){hit=true;break}}
    if(!hit)for(const o of near){const lim=(s.rad+o.rad)*1.3+10;for(let i=0;i<o.seg.length;i+=2){const p=o.seg[i];if((p.x-px)**2+(p.y-py)**2<lim*lim){hit=true;break}}if(hit)break}
    if(hit){sc-=20-dist/10;break}}
   if(sc>bs){bs=sc;bestA=a}}
  s.plan=bestA;s.fleeing=flee!==null;
 }
 s.boost=(s.hunt||s.fleeing)&&s.seg.length>24;
 s.ang+=Math.max(-.11,Math.min(.11,da(s.plan-s.ang)));
}
function step(s){
 const rad=s.rad=radOf(s.seg.length),gap=Math.max(10,rad*.55);
 const sp=s.boost&&s.seg.length>14?4:2.5,h=s.seg[0];
 h.x+=Math.cos(s.ang)*sp;h.y+=Math.sin(s.ang)*sp;
 for(let i=1;i<s.seg.length;i++){const p=s.seg[i-1],q=s.seg[i],dx=p.x-q.x,dy=p.y-q.y,d=Math.hypot(dx,dy);if(d>gap){q.x=p.x-dx/d*gap;q.y=p.y-dy/d*gap}}
 const want=wantOf(s.score);
 while(s.seg.length<want){const l=s.seg[s.seg.length-1];s.seg.push({x:l.x,y:l.y})}
 if(s.boost&&s.seg.length>14&&T%12===0){s.score=Math.max(0,s.score-20);const l=s.seg.pop();orb(l.x,l.y,1)}
 for(let i=orbs.length-1;i>=0;i--){const o=orbs[i];if((o.x-h.x)**2+(o.y-h.y)**2<(rad+o.r+14)**2){s.score+=o.v*10;orbs.splice(i,1)}}
 if(h.x<0||h.x>W||h.y<0||h.y>W){die(s,null);return}
 for(const o of snakes){if(o===s||!o.alive)continue;const lim=(rad+o.rad)*.8;
  for(let i=0;i<o.seg.length;i+=2){const p=o.seg[i];if((p.x-h.x)**2+(p.y-h.y)**2<lim*lim){die(s,o);return}}}
}
function update(){T++;
 const p=snakes[0];
 for(const s of snakes){if(!s||!s.alive)continue;if(s.id===0){s.boost=boost&&s.seg.length>14;s.ang+=Math.max(-.12,Math.min(.12,da(mouse-s.ang)))}else ai(s);step(s)}
 if(T===30&&snakes[1].alive)die(snakes[1],snakes[0]);
 if(T===100&&snakes[2].alive&&snakes[3].alive)die(snakes[2],snakes[3]);
 for(const o of orbs)if(o.vx){o.x+=o.vx;o.y+=o.vy;o.vx*=.92;o.vy*=.92;if(Math.abs(o.vx)+Math.abs(o.vy)<.1)o.vx=o.vy=0}
 while(orbs.length<1800)orb(R()*W,R()*W);
 for(let i=parts.length-1;i>=0;i--){const q=parts[i];q.r+=4;q.l-=.03;if(q.l<=0)parts.splice(i,1)}
 if(p.alive){cam.x+=(p.seg[0].x-cam.x)*.12;cam.y+=(p.seg[0].y-cam.y)*.12;
  const zt=Math.max(.2,.7*Math.min(1,14/p.rad)**.6);cam.z+=(zt-cam.z)*.04}
 if(T%120===0){const top=snakes.filter(s=>s.alive).sort((a,b)=>b.score-a.score)[0];
  if(top&&top.name!==leader){leader=top.name;log('g','GAME',`Player ${top.name} is in first place! (${fmt(Math.floor(top.score))} pts)`)}}
 if(T%15===0){const top=snakes.filter(s=>s.alive).sort((a,b)=>b.score-a.score).slice(0,5);
  lb.innerHTML='<b>Placar</b>'+top.map(s=>`<div style="color:${s.c[0]}"><span>${s.name}</span><span>${fmt(Math.floor(s.score))}</span></div>`).join('')}
}
function eyes(g,x,y,ang,rad){const px=-Math.sin(ang),py=Math.cos(ang);
 for(const k of[-1,1]){const ex=x+Math.cos(ang)*rad*.4+px*k*rad*.5,ey=y+Math.sin(ang)*rad*.4+py*k*rad*.5;
  g.fillStyle='#fff';g.beginPath();g.arc(ex,ey,rad*.3,0,6.3);g.fill();
  g.fillStyle='#111';g.beginPath();g.arc(ex+Math.cos(ang)*rad*.1,ey+Math.sin(ang)*rad*.1,rad*.15,0,6.3);g.fill()}}
function crown(g,x,y){g.fillStyle='#ffd000';g.beginPath();g.moveTo(x-9,y+9);g.lineTo(x-9,y);g.lineTo(x-4,y+5);g.lineTo(x,y-3);g.lineTo(x+4,y+5);g.lineTo(x+9,y);g.lineTo(x+9,y+9);g.closePath();g.fill()}
function draw(){
 ctx.fillStyle='#07051a';ctx.fillRect(0,0,VW,VH);
 const z=cam.z,vw=VW/z,vh=VH/z,cx=cam.x-vw/2,cy=cam.y-vh/2;
 ctx.save();ctx.scale(z,z);ctx.translate(-cx,-cy);
 ctx.lineWidth=1;
 ctx.strokeStyle='rgba(0,229,255,.13)';ctx.beginPath();
 for(let c=Math.floor((cx+cy)/80)*80;c<cx+cy+vw+vh;c+=80){ctx.moveTo(cx,c-cx);ctx.lineTo(cx+vw,c-cx-vw)}ctx.stroke();
 ctx.strokeStyle='rgba(255,62,165,.13)';ctx.beginPath();
 for(let c=Math.floor((cx-cy-vh)/80)*80;c<cx-cy+vw;c+=80){ctx.moveTo(cx,cx-c);ctx.lineTo(cx+vw,cx+vw-c)}ctx.stroke();
 ctx.strokeStyle='#ff3ea5';ctx.lineWidth=5;ctx.strokeRect(0,0,W,W);
 for(const o of orbs){if(o.x<cx-20||o.x>cx+vw+20||o.y<cy-20||o.y>cy+vh+20)continue;
  const r=o.r*(1+.3*Math.sin(T/10+o.h)),c=`hsl(${o.h},100%,62%)`;
  ctx.globalAlpha=.25;ctx.fillStyle=c;ctx.beginPath();ctx.arc(o.x,o.y,r*2.2,0,6.3);ctx.fill();
  ctx.globalAlpha=1;ctx.beginPath();ctx.arc(o.x,o.y,r,0,6.3);ctx.fill()}
 for(const q of parts){ctx.globalAlpha=Math.max(0,q.l);ctx.strokeStyle=q.c;ctx.lineWidth=4;ctx.beginPath();ctx.arc(q.x,q.y,q.r,0,6.3);ctx.stroke()}
 ctx.globalAlpha=1;
 const fs=15*Math.min(2.2,.7/z);
 for(const s of snakes){if(!s||!s.alive)continue;const n=s.seg.length;
  for(let i=n-1;i>=0;i--){const p=s.seg[i];if(p.x<cx-30||p.x>cx+vw+30||p.y<cy-30||p.y>cy+vh+30)continue;
   const t=i/n,col=segCol(s,i,n),r=s.rad*(1-.3*t);
   ctx.fillStyle=col;ctx.globalAlpha=.18;ctx.beginPath();ctx.arc(p.x,p.y,r*1.7,0,6.3);ctx.fill();
   ctx.globalAlpha=1;ctx.beginPath();ctx.arc(p.x,p.y,r,0,6.3);ctx.fill()}
  const h=s.seg[0];
  eyes(ctx,h.x,h.y,s.ang,s.rad);
  if(s.boost){ctx.strokeStyle=s.c[0];ctx.lineWidth=2;ctx.beginPath();ctx.arc(h.x,h.y,s.rad*2,0,6.3);ctx.stroke()}
  if(s.id===0&&s.crown)crown(ctx,h.x,h.y-s.rad-16);
  ctx.fillStyle='#fff';ctx.font=`bold ${fs}px system-ui,sans-serif`;ctx.textAlign='center';ctx.fillText(s.name,h.x,h.y-s.rad-(s.id===0&&s.crown?22:8));
 }
 ctx.restore();
}
// ---- personalização ----
const pv=document.getElementById('pv'),nm=document.getElementById('nm'),c1=document.getElementById('c1'),c2=document.getElementById('c2'),crownBt=document.getElementById('crown');
function paintPrev(){const g=pv.getContext('2d'),w=pv.width,h=pv.height;g.clearRect(0,0,w,h);
 const s={c:[cfg.c1,cfg.c2],pat:cfg.pat},n=20,hx=w-70,r0=20;
 for(let i=n-1;i>=0;i--){const x=hx-i*13,y=h/2+8+Math.sin(i*.45)*16,r=r0*(1-.3*i/n);
  g.fillStyle=segCol(s,i,n);g.globalAlpha=.18;g.beginPath();g.arc(x,y,r*1.6,0,6.3);g.fill();g.globalAlpha=1;g.beginPath();g.arc(x,y,r,0,6.3);g.fill()}
 const hy=h/2+8;eyes(g,hx,hy,0,r0);
 if(cfg.crown)crown(g,hx,hy-r0-14);
 g.fillStyle='#fff';g.font='bold 14px system-ui,sans-serif';g.textAlign='center';g.fillText(cfg.name||'Sem nome',hx,hy-r0-(cfg.crown?20:8));
}
function sync(){nm.value=cfg.name;c1.value=cfg.c1;c2.value=cfg.c2;crownBt.classList.toggle('on',cfg.crown);crownBt.setAttribute('aria-pressed',cfg.crown);
 document.querySelectorAll('#pats .chip').forEach(b=>b.classList.toggle('on',+b.dataset.p===cfg.pat));
 document.querySelectorAll('#presets .sw').forEach(b=>b.classList.toggle('on',b.dataset.a===cfg.c1&&b.dataset.b===cfg.c2));paintPrev()}
pal.slice(0,10).forEach(([a,b])=>{const b1=document.createElement('button');b1.className='sw';b1.dataset.a=a;b1.dataset.b=b;b1.setAttribute('aria-label','Combinação '+a+' e '+b);
 b1.style.background=`linear-gradient(135deg,${a},${b})`;b1.onclick=()=>{cfg.c1=a;cfg.c2=b;sync()};document.getElementById('presets').appendChild(b1)});
['Degradê','Listras','Sólida','Arco-íris'].forEach((l,i)=>{const b1=document.createElement('button');b1.className='chip';b1.dataset.p=i;b1.textContent=l;b1.onclick=()=>{cfg.pat=i;sync()};document.getElementById('pats').appendChild(b1)});
nm.oninput=()=>{cfg.name=nm.value;paintPrev()};
c1.oninput=()=>{cfg.c1=c1.value;sync()};c2.oninput=()=>{cfg.c2=c2.value;sync()};
crownBt.onclick=()=>{cfg.crown=!cfg.crown;sync()};
function play(){cfg.name=(nm.value.trim()||'COBRA').slice(0,14);save();playing=true;start();cust.style.display='none'}
document.getElementById('go').onclick=play;
document.getElementById('again').onclick=()=>{playing=true;start()};
document.getElementById('edit').onclick=()=>{playing=false;start();sync();cust.style.display='grid'};
nm.addEventListener('keydown',e=>{if(e.key==='Enter')play()});
// ---- controles ----
function aim(x,y){const r=cv.getBoundingClientRect();mouse=Math.atan2(y-r.top-VH/2,x-r.left-VW/2)}
cv.addEventListener('pointermove',e=>aim(e.clientX,e.clientY));
cv.addEventListener('pointerdown',e=>{aim(e.clientX,e.clientY);if(e.pointerType==='mouse')boost=true});
addEventListener('pointerup',()=>boost=false);
addEventListener('keydown',e=>{if(e.target.closest('input,button'))return;if(e.code==='Space'){boost=true;e.preventDefault()}});
addEventListener('keyup',e=>{if(e.code==='Space')boost=false});
const bt=document.getElementById('bt');bt.addEventListener('pointerdown',e=>{e.stopPropagation();boost=true});
start();sync();
(function loop(){if(playing)update();draw();requestAnimationFrame(loop)})();
