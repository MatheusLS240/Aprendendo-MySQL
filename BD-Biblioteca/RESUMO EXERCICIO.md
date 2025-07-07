# **Projeto de Banco de Dados: Gerenciamento de Biblioteca**

Este documento apresenta uma sugestão de estrutura para um banco de dados relacional destinado ao gerenciamento de uma biblioteca, incluindo as tabelas, suas colunas e tipos de dados utilizados, bem como uma série de análises que podem ser realizadas com os dados.

---

## **Estrutura do Banco de Dados**

A base do sistema é composta por cinco tabelas principais, interligadas para armazenar e organizar as informações da biblioteca.

### **Tabela: `autor`**

Armazena informações dos autores dos livros cadastrados.

| Coluna            | Tipo de Dados | Descrição                     | Observações             |
| ----------------- | ------------- | ----------------------------- | ----------------------- |
| `cod_autor`       | INT           | Identificador único do autor. | **PK (Chave Primária)** |
| `nome`            | VARCHAR(80)   | Nome completo do autor.       |                         |
| `nacionalidade`   | VARCHAR(30)   | Nacionalidade do autor.       |                         |
| `data_nascimento` | DATE          | Data de nascimento.           |                         |

### **Tabela: `livro`**

Contém os dados dos livros disponíveis no acervo.

| Coluna      | Tipo de Dados | Descrição                                    | Observações         |
| ----------- | ------------- | -------------------------------------------- | ------------------- |
| `cod_livro` | INT           | Identificador único do livro.                | **PK**              |
| `titulo`    | VARCHAR(255)  | Título do livro.                             |                     |
| `editora`   | VARCHAR(255)  | Nome da editora responsável pela publicação. |                     |
| `ano`       | INT           | Ano de publicação do livro.                  |                     |
| `cod_autor` | INT           | Relaciona o livro a um autor.                | **FK para `autor`** |

### **Tabela: `endereco`**

Armazena os dados completos de endereço dos clientes.

| Coluna         | Tipo de Dados | Descrição                        | Observações   |
| -------------- | ------------- | -------------------------------- | ------------- |
| `cod_endereco` | INT           | Identificador único do endereço. | **PK**        |
| `estado`       | VARCHAR(30)   | Estado (UF).                     |               |
| `cidade`       | VARCHAR(30)   | Cidade.                          |               |
| `bairro`       | VARCHAR(30)   | Bairro.                          |               |
| `cep`          | CHAR(9)       | CEP (formato: 00000-000).        |               |
| `rua`          | VARCHAR(60)   | Nome da rua.                     |               |
| `complemento`  | VARCHAR(60)   | Complemento (opcional).          | Pode ser NULL |

### **Tabela: `cliente`**

Armazena os dados dos membros (clientes) da biblioteca.

| Coluna         | Tipo de Dados | Descrição                                     | Observações            |
| -------------- | ------------- | --------------------------------------------- | ---------------------- |
| `cod_cliente`  | INT           | Identificador único do cliente.               | **PK**                 |
| `nome`         | VARCHAR(40)   | Primeiro nome do cliente.                     |                        |
| `sobrenome`    | VARCHAR(60)   | Sobrenome do cliente.                         |                        |
| `email`        | VARCHAR(60)   | E-mail do cliente.                            | **Único**              |
| `cod_endereco` | INT           | Chave estrangeira para o endereço do cliente. | **FK para `endereco`** |

### **Tabela: `emprestimo`**

Registra as transações de empréstimos feitas pelos clientes.

| Coluna              | Tipo de Dados | Descrição                          | Observações           |
| ------------------- | ------------- | ---------------------------------- | --------------------- |
| `cod_emprestimo`    | INT           | Identificador único do empréstimo. | **PK**                |
| `data_emprestimo`   | DATE          | Data do empréstimo.                |                       |
| `data_dev_prevista` | DATE          | Data prevista para devolução.      |                       |
| `data_devolucao`    | DATE          | Data real da devolução.            | Pode ser NULL         |
| `cod_livro`         | INT           | Livro emprestado.                  | **FK para `livro`**   |
| `cod_cliente`       | INT           | Cliente que realizou o empréstimo. | **FK para `cliente`** |

---

## **Observações Importantes sobre a Estrutura**

* **PK (Chave Primária):** Garante a unicidade de cada registro na tabela.
* **FK (Chave Estrangeira):** Mantém a integridade referencial entre as tabelas.
* **Tipos de Dados:** Os nomes (INT, VARCHAR, DATE etc.) são compatíveis com o MySQL.
* **Normalização:** A estrutura segue os princípios de normalização até a 3ª Forma Normal, evitando redundância e melhorando a integridade dos dados.

---

## **Análises Sugeridas para o Banco de Dados `biblioteca`**

A seguir, estão algumas análises que podem ser feitas com esse banco:

### 📚 Livros e Autores

* Quais são os 5 autores com o maior número de livros cadastrados?
* Quantos livros cada editora publicou, e qual o ano mais comum de publicação por editora?
* Qual a idade média dos autores brasileiros no ano de publicação de seu primeiro livro?
* Quais livros foram escritos por autores de uma nacionalidade específica?

### 👤 Clientes e Endereços

* Qual estado tem mais clientes cadastrados?
* Quais clientes moram em um determinado bairro e cidade?
* Contagem de clientes por cidade e por estado.
* Existem clientes sem endereço associado?

### 🔄 Empréstimos

* Qual livro foi mais emprestado?
* Qual cliente mais realizou empréstimos?
* Quantos empréstimos estão em aberto (`data_devolucao` é NULL)?
* Quais empréstimos estão atrasados (`data_dev_prevista` passou e `data_devolucao` ainda é NULL)?
* Qual a duração média dos empréstimos (em dias)?
* Quais livros foram emprestados por um cliente específico?
* Quantos empréstimos foram feitos em um determinado mês/ano?

### 🔗 Análises Combinadas

* Quais autores têm livros atualmente emprestados?
* Quais livros estão com membros de um estado específico?
* Quais clientes já emprestaram livros de um autor específico?
* Qual a editora dos livros com maior atraso na devolução?
* Quais clientes nunca fizeram um empréstimo?

---

> **⚠️ Observação:**
> Os exercícios e análises foram sugeridos com base na estrutura acima e nas tabelas reais do projeto `biblioteca`. Pequenas diferenças podem surgir dependendo das implementações feitas no banco real.