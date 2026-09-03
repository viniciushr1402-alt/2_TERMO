# 🌐 HTML — HyperText Markup Language

## 📖 O que é HTML?

HTML significa **HyperText Markup Language**, que em português significa **Linguagem de Marcação de Hipertexto**.

HTML é utilizado para criar a **estrutura de páginas e aplicações web**. Ele permite organizar textos, imagens, vídeos, links, formulários, tabelas e diversos outros elementos que aparecem em uma página.

HTML **não é uma linguagem de programação**, pois não possui estruturas como condições e loops para executar lógica. Ele é uma **linguagem de marcação**, baseada em elementos e tags.

---

## 🎯 Para que serve o HTML?

O HTML pode ser utilizado para:

* Criar páginas para a internet.
* Organizar conteúdos de uma página.
* Adicionar textos e títulos.
* Inserir imagens e vídeos.
* Criar links para outras páginas.
* Criar listas.
* Criar tabelas.
* Criar formulários.
* Organizar menus e seções.
* Estruturar conteúdos para mecanismos de busca.
* Criar a base de sites e aplicações web.
* Trabalhar em conjunto com CSS e JavaScript.

---

## 🧱 Estrutura básica do HTML

Um documento HTML possui uma estrutura padrão:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Minha Página</title>
</head>

<body>

    <h1>Olá, mundo!</h1>
    <p>Este é meu primeiro site.</p>

</body>
</html>
```

### 🔹 Principais partes

* `<!DOCTYPE html>` → informa ao navegador que o documento utiliza HTML5.
* `<html>` → elemento principal do documento.
* `<head>` → contém informações e configurações da página.
* `<title>` → define o título exibido na aba do navegador.
* `<body>` → contém todo o conteúdo que será exibido na página.

---

# 🏷️ Tags HTML

As **tags** são utilizadas para indicar ao navegador como determinado conteúdo deve ser interpretado.

Exemplo:

```html
<h1>Meu título</h1>
<p>Meu parágrafo.</p>
```

Nesse exemplo:

* `<h1>` representa um título.
* `<p>` representa um parágrafo.

Algumas tags possuem abertura e fechamento:

```html
<p>Texto</p>
```

Outras não precisam de uma tag de fechamento, como:

```html
<img src="imagem.jpg">
```

---

# 📝 Títulos

O HTML possui seis níveis de títulos:

```html
<h1>Título principal</h1>
<h2>Subtítulo</h2>
<h3>Título menor</h3>
<h4>Outro título</h4>
<h5>Título</h5>
<h6>Título menor</h6>
```

O `<h1>` representa o título de maior importância e o `<h6>` o de menor importância.

---

# 📄 Parágrafos

A tag `<p>` é utilizada para criar parágrafos.

```html
<p>Este é um exemplo de parágrafo.</p>
```

Também é possível utilizar:

```html
<br>
```

para realizar uma quebra de linha.

---

# 🔗 Links

A tag `<a>` é utilizada para criar links.

```html
<a href="https://www.google.com">Google</a>
```

O atributo `href` indica o endereço para onde o usuário será direcionado.

---

# 🖼️ Imagens

A tag `<img>` é utilizada para adicionar imagens.

```html
<img src="imagem.jpg" alt="Descrição da imagem">
```

### Principais atributos:

* `src` → indica o caminho da imagem.
* `alt` → fornece uma descrição da imagem.

O atributo `alt` também é importante para **acessibilidade**.

---

# 📋 Listas

## Lista não ordenada

Utiliza a tag `<ul>`:

```html
<ul>
    <li>HTML</li>
    <li>CSS</li>
    <li>JavaScript</li>
</ul>
```

Resultado:

* HTML
* CSS
* JavaScript

## Lista ordenada

Utiliza a tag `<ol>`:

```html
<ol>
    <li>Primeiro</li>
    <li>Segundo</li>
    <li>Terceiro</li>
</ol>
```

Resultado:

1. Primeiro
2. Segundo
3. Terceiro

---

# 📊 Tabelas

HTML também permite criar tabelas.

```html
<table>
    <tr>
        <th>Nome</th>
        <th>Idade</th>
    </tr>

    <tr>
        <td>João</td>
        <td>18</td>
    </tr>
</table>
```

### Principais tags:

* `<table>` → cria a tabela.
* `<tr>` → cria uma linha.
* `<th>` → cria uma célula de cabeçalho.
* `<td>` → cria uma célula comum.

---

# 📝 Formulários

A tag `<form>` é utilizada para criar formulários.

```html
<form>
    <label>Nome:</label>
    <input type="text">

    <label>Email:</label>
    <input type="email">

    <button type="submit">Enviar</button>
</form>
```

Alguns elementos utilizados em formulários:

* `<form>` → formulário.
* `<label>` → identifica um campo.
* `<input>` → campo para entrada de dados.
* `<textarea>` → área para textos maiores.
* `<select>` → cria uma lista de opções.
* `<option>` → representa uma opção.
* `<button>` → cria um botão.

---

# ⚙️ Atributos HTML

Os atributos fornecem informações adicionais para os elementos.

Exemplo:

```html
<p class="texto">Olá!</p>
```

Nesse caso, `class="texto"` é um atributo.

Alguns atributos comuns:

* `id`
* `class`
* `href`
* `src`
* `alt`
* `title`
* `style`
* `name`
* `value`
* `placeholder`
* `type`

---

# 🆔 ID

O atributo `id` identifica um elemento de forma única.

```html
<h1 id="titulo">Meu site</h1>
```

Um `id` normalmente deve ser utilizado para identificar **um elemento específico**.

---

# 🏷️ CLASS

O atributo `class` pode ser utilizado em vários elementos.

```html
<p class="texto">Primeiro texto</p>
<p class="texto">Segundo texto</p>
```

Classes são muito utilizadas em conjunto com **CSS**.

---

# 📦 DIV

A tag `<div>` é um elemento utilizado para agrupar e organizar outros elementos.

```html
<div>
    <h1>Meu site</h1>
    <p>Bem-vindo ao meu site!</p>
</div>
```

A `<div>` é muito utilizada para estruturar páginas.

---

# 🧩 HTML Semântico

HTML5 possui elementos semânticos que ajudam a representar o significado de cada parte da página.

Alguns exemplos:

```html
<header>
    Cabeçalho
</header>

<nav>
    Menu
</nav>

<main>
    Conteúdo principal
</main>

<section>
    Seção
</section>

<article>
    Artigo
</article>

<footer>
    Rodapé
</footer>
```

Principais elementos semânticos:

* `<header>` → cabeçalho.
* `<nav>` → área de navegação.
* `<main>` → conteúdo principal.
* `<section>` → seção de conteúdo.
* `<article>` → conteúdo independente.
* `<aside>` → conteúdo relacionado ou lateral.
* `<footer>` → rodapé.

---

# 🎥 Áudio e Vídeo

HTML permite adicionar conteúdos multimídia.

## Vídeo

```html
<video controls>
    <source src="video.mp4" type="video/mp4">
</video>
```

## Áudio

```html
<audio controls>
    <source src="musica.mp3" type="audio/mpeg">
</audio>
```

O atributo `controls` adiciona controles para o usuário reproduzir o conteúdo.

---

# 💬 Comentários

Comentários podem ser adicionados utilizando:

```html
<!-- Este é um comentário -->
```

Os comentários não são exibidos visualmente na página.

Eles podem ser utilizados para explicar partes do código ou facilitar sua organização.

---

# 🎨 HTML + CSS + JavaScript

HTML normalmente trabalha junto com outras tecnologias.

### HTML

Responsável pela **estrutura**.

```text
HTML = Estrutura
```

### CSS

Responsável pela **aparência e estilo**.

```text
CSS = Estilo
```

### JavaScript

Responsável pela **interatividade e comportamento**.

```text
JavaScript = Interação
```

Uma forma simples de entender:

```text
HTML       → Corpo/Estrutura
CSS        → Aparência
JavaScript → Comportamento
```

---

# 📁 Extensão dos arquivos

Arquivos HTML normalmente utilizam:

```text
.html
```

Exemplo:

```text
index.html
```

O arquivo `index.html` é frequentemente utilizado como a página inicial de um site.

---

# 💻 HTML no VS Code

O **Visual Studio Code** é um editor de código que pode ser utilizado para desenvolver páginas HTML.

Para criar uma página:

1. Abra o VS Code.
2. Crie uma pasta para o projeto.
3. Crie um arquivo chamado `index.html`.
4. Escreva o código HTML.
5. Salve o arquivo.
6. Abra o arquivo em um navegador.

No VS Code, também é possível utilizar o **Emmet** para facilitar a escrita do HTML.

Por exemplo:

```html
!
```

seguido de `Enter` pode gerar automaticamente a estrutura básica do HTML.

---

# 🚀 HTML5

HTML5 é uma versão moderna do HTML que trouxe diversos recursos para desenvolvimento web.

Entre eles:

* Elementos semânticos.
* Suporte melhorado para áudio.
* Suporte melhorado para vídeo.
* Melhor estrutura de formulários.
* Novos tipos de `<input>`.
* Recursos voltados para aplicações web.
* Melhor suporte para acessibilidade.

---

# ♿ Acessibilidade

Um bom código HTML deve levar em consideração pessoas que utilizam tecnologias assistivas.

Algumas boas práticas:

* Utilizar `alt` em imagens.
* Utilizar títulos na ordem correta.
* Utilizar elementos semânticos.
* Utilizar `<label>` nos campos de formulário.
* Utilizar textos claros nos links.
* Manter uma estrutura organizada.

Exemplo:

```html
<img src="gato.jpg" alt="Gato sentado em uma cadeira">
```

---

# 🔍 HTML e SEO

HTML também pode ajudar na **otimização para mecanismos de busca (SEO)**.

Algumas práticas importantes:

* Utilizar títulos adequados.
* Utilizar `<title>`.
* Utilizar descrições.
* Utilizar HTML semântico.
* Organizar corretamente os títulos `<h1>` até `<h6>`.
* Utilizar textos alternativos nas imagens.
* Criar uma estrutura clara para o conteúdo.

---

# 📌 Tags importantes

| Tag         | Função                           |
| ----------- | -------------------------------- |
| `<html>`    | Documento HTML                   |
| `<head>`    | Informações da página            |
| `<title>`   | Título da página                 |
| `<body>`    | Conteúdo visível                 |
| `<h1>`      | Título principal                 |
| `<p>`       | Parágrafo                        |
| `<a>`       | Link                             |
| `<img>`     | Imagem                           |
| `<ul>`      | Lista não ordenada               |
| `<ol>`      | Lista ordenada                   |
| `<li>`      | Item da lista                    |
| `<div>`     | Agrupamento de elementos         |
| `<span>`    | Agrupamento de conteúdo em linha |
| `<table>`   | Tabela                           |
| `<form>`    | Formulário                       |
| `<input>`   | Campo de entrada                 |
| `<button>`  | Botão                            |
| `<header>`  | Cabeçalho                        |
| `<nav>`     | Navegação                        |
| `<main>`    | Conteúdo principal               |
| `<section>` | Seção                            |
| `<article>` | Artigo/conteúdo independente     |
| `<footer>`  | Rodapé                           |

---

# 📚 Resumo

HTML é uma das principais tecnologias utilizadas no desenvolvimento web.

Ele é responsável principalmente pela **estrutura e organização do conteúdo** de uma página.

Os principais conceitos estudados em HTML são:

* Tags
* Elementos
* Atributos
* Estrutura do documento
* Títulos
* Parágrafos
* Links
* Imagens
* Listas
* Tabelas
* Formulários
* HTML semântico
* Acessibilidade
* HTML5

HTML pode ser utilizado junto com **CSS e JavaScript** para criar páginas e aplicações web completas.

---

## 🔗 Tecnologias relacionadas

* 🌐 **HTML** → Estrutura
* 🎨 **CSS** → Estilização
* ⚡ **JavaScript** → Interatividade
* 🗄️ **SQL** → Banco de dados
* 🐍 **Python** → Programação e back-end
* 🐙 **Git/GitHub** → Controle e armazenamento de versões

---

## 👨‍💻 Exemplo completo

```html
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Site</title>
</head>

<body>

    <header>
        <h1>Meu Site</h1>
    </header>

    <nav>
        <a href="#">Início</a>
        <a href="#">Sobre</a>
        <a href="#">Contato</a>
    </nav>

    <main>

        <section>
            <h2>Sobre o site</h2>
            <p>Este é um exemplo de página criada utilizando HTML.</p>
        </section>

        <section>
            <h2>Imagem</h2>
            <img src="imagem.jpg" alt="Imagem de exemplo">
        </section>

        <section>
            <h2>Contato</h2>

            <form>
                <label>Nome:</label>
                <input type="text" placeholder="Digite seu nome">

                <label>Email:</label>
                <input type="email" placeholder="Digite seu email">

                <button type="submit">Enviar</button>
            </form>

        </section>

    </main>

    <footer>
        <p>© 2026 - Meu Site</p>
    </footer>

</body>

</html>
```
