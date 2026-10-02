const readline = require('readline-sync');
const sensor = require('./sensor');


const temp = readline.question('Informe a temperatura atual: ');
const umid = readline.question('Informe a umidade atual: ');

console.log(sensor.checarTemperatura(temp));
console.log(sensor.checarUmidade(umid));
