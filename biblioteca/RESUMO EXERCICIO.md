---

# **Projeto de Banco de Dados: Gerenciamento de Biblioteca**

Este documento apresenta uma sugestão de estrutura para um banco de dados relacional destinado ao gerenciamento de uma biblioteca, incluindo as tabelas, suas colunas e tipos de dados sugeridos, bem como uma série de análises que podem ser realizadas com os dados.

---

## **Estrutura do Banco de Dados**

A base do sistema é composta por quatro tabelas principais que se relacionam para armazenar e organizar as informações da biblioteca.

### **Tabela: `Autores`**
Esta tabela armazenará informações detalhadas sobre os autores dos livros.

| Coluna         | Tipo Sugerido | Descrição                                    | Observações             |
| :------------- | :------------ | :------------------------------------------- | :---------------------- |
| `AutorID`      | Inteiro       | Identificador único para cada autor.         | **PK (Chave Primária)** |
| `Nome`         | Texto         | Nome completo do autor (ex: "Gabriel García Márquez"). |                         |
| `Nacionalidade`| Texto         | Nacionalidade do autor (ex: "Colombiana").  |                         |
| `DataNascimento`| Data          | Data de nascimento do autor (ex: "1927-03-06"). |                         |

### **Tabela: `Livros`**
Esta tabela conterá os detalhes de cada livro disponível no acervo da biblioteca.

| Coluna          | Tipo Sugerido | Descrição                                    | Observações             |
| :-------------- | :------------ | :------------------------------------------- | :---------------------- |
| `LivroID`       | Inteiro       | Identificador único para cada livro.         | **PK (Chave Primária)** |
| `Titulo`        | Texto         | Título completo do livro (ex: "Cem Anos de Solidão"). |                         |
| `AnoPublicacao` | Inteiro       | Ano da primeira publicação do livro (ex: 1967). |                         |
| `ISBN`          | Texto         | Identificador Padrão Internacional do Livro (ex: "978-8535914844"). | Único para cada livro.  |
| `AutorID`       | Inteiro       | Chave estrangeira para vincular o livro ao seu autor. | **FK para `Autores`** |

### **Tabela: `Membros`**
Esta tabela armazenará as informações sobre os usuários da biblioteca que podem pegar livros emprestados.

| Coluna         | Tipo Sugerido | Descrição                                    | Observações             |
| :------------- | :------------ | :------------------------------------------- | :---------------------- |
| `MembroID`     | Inteiro       | Identificador único para cada membro.        | **PK (Chave Primária)** |
| `Nome`         | Texto         | Primeiro nome do membro (ex: "Ana").         |                         |
| `Sobrenome`    | Texto         | Sobrenome do membro (ex: "Silva").           |                         |
| `Endereco`     | Texto         | Endereço completo do membro (ex: "Rua das Flores, 123"). |                         |
| `Telefone`     | Texto         | Número de telefone do membro (ex: "(11) 98765-4321"). |                         |
| `Email`        | Texto         | Endereço de e-mail do membro.                | Único para cada membro. |

### **Tabela: `Emprestimos`**
Esta tabela registrará cada transação de empréstimo de um livro.

| Coluna              | Tipo Sugerido | Descrição                                    | Observações                      |
| :------------------ | :------------ | :------------------------------------------- | :------------------------------- |
| `EmprestimoID`      | Inteiro       | Identificador único para cada empréstimo.    | **PK (Chave Primária)** |
| `LivroID`           | Inteiro       | Chave estrangeira para o livro emprestado.   | **FK para `Livros`** |
| `MembroID`          | Inteiro       | Chave estrangeira para o membro que fez o empréstimo. | **FK para `Membros`** |
| `DataEmprestimo`    | Data          | Data em que o livro foi emprestado (ex: "2024-07-05"). |                                  |
| `DataDevolucaoPrevista`| Data          | Data limite para a devolução do livro (ex: "2024-07-19"). |                                  |
| `DataDevolucaoReal` | Data          | Data em que o livro foi realmente devolvido. | Pode ser NULO se o livro ainda não foi devolvido. |

---

## **Observações Importantes sobre a Estrutura:**

* **PK (Chave Primária):** É uma coluna (ou conjunto de colunas) que garante que cada registro na tabela seja único. Essencial para identificar de forma exclusiva cada linha.
* **FK (Chave Estrangeira):** Uma coluna em uma tabela que referencia a chave primária de outra tabela. Ela estabelece e reforça a ligação entre as tabelas, garantindo a integridade referencial dos dados.
* **Tipos de Dados:** As sugestões (Inteiro, Texto, Data) são conceitos gerais. Ao implementar em um SGBD real (como MySQL, PostgreSQL, SQL Server), você escolherá os tipos de dados específicos (e.g., `INT`, `VARCHAR(255)`, `DATE`, `DATETIME`).
* **Normalização:** Esta estrutura básica segue os princípios de normalização de banco de dados, minimizando a redundância e melhorando a integridade dos dados.

---

### **Análises Sugeridas para o Banco de Dados `biblioteca`**

Com base na estrutura acima, você pode fazer diversas análises e obter insights valiosos sobre o funcionamento da sua biblioteca.

#### **1. Análises sobre Livros e Autores:**

* Quais são os 5 autores com o maior número de livros cadastrados na biblioteca?
* Para cada editora, quantos livros ela publicou e qual é o ano de publicação mais comum entre esses livros?
* Considerando o ano de publicação do primeiro livro de um autor, qual a idade média dos autores brasileiros nesse momento?
* Liste todos os títulos de livros escritos por autores de uma nacionalidade específica (por exemplo, "Britânica").

#### **2. Análises sobre Membros (Clientes) e Endereços:**

* Qual estado brasileiro possui a maior concentração de membros cadastrados na biblioteca?
* Liste os nomes completos de todos os membros que residem em um bairro e cidade específicos.
* Apresente a contagem de membros por cada cidade e, em seguida, por cada estado.
* Existem membros cadastrados que não possuem um endereço associado em seus registros?

#### **3. Análises sobre Empréstimos:**

* Qual é o título do livro que foi emprestado o maior número de vezes?
* Qual membro (nome e sobrenome) realizou a maior quantidade de empréstimos?
* Quantos empréstimos estão atualmente em status de "aberto" (ou seja, ainda não foram devolvidos)?
* Quais empréstimos estão com a devolução atrasada (ou seja, a `DataDevolucaoPrevista` já passou e a `DataDevolucaoReal` é `NULL`)?
* Calcule a duração média (em dias) de um empréstimo de livro na biblioteca.
* Liste todos os livros (título e editora) que foram emprestados por um membro específico.
* Quantos empréstimos totais foram registrados em um determinado mês e ano?

#### **4. Análises Combinadas (Unindo Informações de Múltiplas Tabelas):**

* Liste o nome dos autores cujos livros estão atualmente emprestados.
* Quais são os títulos dos livros que estão atualmente em posse de membros de um estado específico?
* Liste os nomes completos de todos os membros que já emprestaram livros de um determinado autor.
* Qual é a editora dos livros que estão há mais tempo com a devolução atrasada?
* Identifique e liste os membros que, até o momento, nunca realizaram um empréstimo na biblioteca.

### -- EXERCÍCIOS SOLICITADOS PARA A IA, PORTANTO, PODE HAVER PEQUENAS DIFERENÇAS --