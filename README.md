# 💻 Desenvolvimento de Sistemas

> Repositório destinado aos estudos e projetos desenvolvidos durante o curso de **Desenvolvimento de Sistemas**.

## 📚 Tecnologias e conteúdos

| 🌐 Front-end | ⚙️ Back-end | 🗄️ Banco de Dados | 🛠️ Ferramentas |
| ------------ | ----------- | ------------------ | --------------- |
| HTML         | Python      | MySQL              | VS Code         |
| CSS          | APIs        | SQL                | Git             |
| JavaScript   | HTTP        | Modelagem          | GitHub          |

---

## 🌐 HTML

**HTML (HyperText Markup Language)** é uma linguagem de marcação utilizada para estruturar páginas web.

**Principais conceitos:**

* Tags e elementos
* Atributos
* Títulos e parágrafos
* Links e imagens
* Listas e tabelas
* Formulários
* HTML semântico

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Minha Página</title>
</head>
<body>
    <h1>Olá, mundo!</h1>
    <p>Minha primeira página.</p>
</body>
</html>
```

---

## 🎨 CSS

**CSS (Cascading Style Sheets)** é responsável pela aparência e estilização das páginas HTML.

**Principais conceitos:**

* Seletores
* Classes e IDs
* Cores e fontes
* Margens e espaçamentos
* Box Model
* Flexbox
* Grid
* Responsividade
* Media Queries

```css
body {
    font-family: Arial;
}

.container {
    display: flex;
    gap: 20px;
}
```

---

## ⚡ JavaScript

**JavaScript** é uma linguagem de programação utilizada principalmente para adicionar interatividade e lógica às páginas web.

**Principais conceitos:**

* Variáveis
* Tipos de dados
* Operadores
* Condições
* Loops
* Funções
* Arrays
* Objetos
* DOM
* Eventos
* Requisições

```javascript
let nome = "João";

if (nome) {
    console.log(`Olá, ${nome}!`);
}
```

---

## ⚙️ Back-end

O **Back-end** é responsável pelo processamento das informações, regras de negócio, comunicação com bancos de dados e funcionamento interno de uma aplicação.

**Principais conceitos:**

* Lógica de programação
* Servidores
* APIs
* Requisições e respostas
* HTTP
* JSON
* Autenticação
* CRUD
* Integração com banco de dados

```text
Front-end → API → Back-end → Banco de Dados
```

---

## 🐍 Python

**Python** é uma linguagem de programação utilizada no desenvolvimento de aplicações, automação, análise de dados e também no Back-end.

**Principais conceitos:**

* Variáveis
* Condições
* Repetições
* Funções
* Listas
* Dicionários
* Classes
* Módulos
* Tratamento de erros

```python
def somar(a, b):
    return a + b

resultado = somar(10, 5)
print(resultado)
```

---

## 🗄️ Banco de Dados

Banco de dados é utilizado para **armazenar, organizar e consultar informações**.

### 🐬 MySQL

O **MySQL** é um sistema de gerenciamento de banco de dados relacional que utiliza SQL.

**Principais conceitos:**

* Bancos de dados
* Tabelas
* Registros
* Campos
* Chaves primárias
* Chaves estrangeiras
* Relacionamentos
* Cardinalidade
* Normalização

### 🔑 Chaves

| Chave         | Função                                |
| ------------- | ------------------------------------- |
| `PRIMARY KEY` | Identifica um registro de forma única |
| `FOREIGN KEY` | Relaciona tabelas                     |
| `UNIQUE`      | Impede valores duplicados             |

---

## 💾 SQL

**SQL (Structured Query Language)** é utilizada para criar, consultar e manipular bancos de dados relacionais.

### Principais comandos

```sql
CREATE DATABASE
CREATE TABLE
INSERT
SELECT
UPDATE
DELETE
ALTER TABLE
DROP TABLE
```

### Exemplo

```sql
CREATE DATABASE oficina;

USE oficina;

CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20)
);

INSERT INTO CLIENTE (nome, telefone)
VALUES ('João', '11999999999');

SELECT * FROM CLIENTE;
```

---

## 🔗 Relacionamentos

Os principais tipos de relacionamento entre tabelas são:

```text
1 : 1  → Um para Um
1 : N  → Um para Muitos
N : N  → Muitos para Muitos
```

Exemplo:

```text
CLIENTE 1 ───── N VEÍCULOS
```

Um cliente pode possuir vários veículos.

---

## 🔄 CRUD

CRUD representa as quatro operações básicas de manipulação de dados:

| Operação  | SQL      |
| --------- | -------- |
| 🟢 Create | `INSERT` |
| 🔵 Read   | `SELECT` |
| 🟡 Update | `UPDATE` |
| 🔴 Delete | `DELETE` |

---

## 🌐 API

Uma **API (Application Programming Interface)** permite a comunicação entre diferentes sistemas.

```text
┌──────────────┐
│  Front-end   │
└──────┬───────┘
       ↓
┌──────────────┐
│     API      │
└──────┬───────┘
       ↓
┌──────────────┐
│   Back-end   │
└──────┬───────┘
       ↓
┌──────────────┐
│ Banco Dados  │
└──────────────┘
```

### Métodos HTTP

* `GET` → consultar
* `POST` → criar
* `PUT` → atualizar
* `PATCH` → atualizar parcialmente
* `DELETE` → excluir

---

## 📦 JSON

JSON é um formato utilizado para transmitir informações entre aplicações.

```json
{
    "nome": "João",
    "idade": 18,
    "ativo": true
}
```

---

## 🐙 Git & GitHub

**Git** é utilizado para controle de versão dos projetos.

**GitHub** permite armazenar, compartilhar e colaborar em projetos.

### Comandos básicos

```bash
git init
git add .
git commit -m "Primeiro commit"
git status
git log
git push
git pull
git clone
```

---

## 🖥️ VS Code

O **Visual Studio Code** é o editor utilizado para desenvolver os projetos.

Pode ser utilizado com:

`HTML` • `CSS` • `JavaScript` • `Python` • `SQL` • `JSON` • `Git`

---

## 🧩 Estrutura de uma aplicação

```text
📁 Projeto
├── 📄 index.html
├── 🎨 style.css
├── ⚡ script.js
├── 🐍 backend/
│   └── app.py
├── 🗄️ database/
│   └── banco.sql
└── 🖼️ images/
```

---

## 🚀 Fluxo de desenvolvimento

```text
HTML
  ↓
CSS
  ↓
JavaScript
  ↓
API
  ↓
Back-end
  ↓
Banco de Dados
  ↓
Git / GitHub
```

> 💡 **HTML estrutura, CSS estiliza, JavaScript interage, o Back-end processa e o Banco de Dados armazena.**

---

## 📌 Resumo

| Tecnologia   | Principal função           |
| ------------ | -------------------------- |
| 🌐 HTML      | Estrutura                  |
| 🎨 CSS       | Estilização                |
| ⚡ JavaScript | Interatividade             |
| 🐍 Python    | Programação / Back-end     |
| 🔌 API       | Comunicação entre sistemas |
| 🗄️ MySQL    | Banco de Dados             |
| 💾 SQL       | Manipulação de dados       |
| 🐙 Git       | Controle de versão         |
| ☁️ GitHub    | Hospedagem de código       |
| 🖥️ VS Code  | Desenvolvimento            |

---

### 👨‍💻 Estudos em Desenvolvimento de Sistemas

**HTML • CSS • JavaScript • Python • SQL • MySQL • Back-end • APIs • Git • GitHub**

