USE biblioteca;

-- Exercicios 1 --
-- Quais são os 5 autores com o maior número de livros cadastrados? --
SELECT autor.nome, COUNT(livro.cod_autor) AS numero_livros
FROM livro
JOIN autor ON autor.cod_autor = livro.cod_autor
GROUP BY autor.nome
ORDER BY numero_livros DESC
LIMIT 5;

-- Quantos livros cada editora publicou, e qual o ano mais comum de publicação por editora? --
SELECT editora, COUNT(cod_livro) AS total_livros, AVG(ano) media_livros 
FROM livro
GROUP BY editora
ORDER BY total_livros DESC;

-- Qual a idade média dos autores brasileiros no ano de publicação de seu primeiro livro? --
SELECT nome, TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade_atual
FROM autor
HAVING idade_atual <= 100;

-- Quais livros foram escritos por autores de uma nacionalidade específica? --
SELECT autor.nome, livro.titulo, autor.nacionalidade
FROM livro 
LEFT JOIN autor ON autor.cod_autor = livro.cod_autor
WHERE nacionalidade LIKE '%Britânica%';

-- Exercícios 2 --
-- Qual estado tem mais clientes cadastrados? --
SELECT endereco.estado, COUNT(cliente.cod_cliente) AS total_clientes
FROM endereco
JOIN cliente ON endereco.cod_endereco = cliente.cod_endereco
GROUP BY endereco.estado;

-- Quais clientes moram em um determinado bairro e cidade? --
SELECT cliente.nome, cliente.sobrenome, endereco.bairro, endereco.cidade
FROM cliente
JOIN endereco ON cliente.cod_endereco = endereco.cod_endereco
WHERE endereco.bairro LIKE 'copacabana'
AND endereco.cidade LIKE 'Rio de janeiro';

-- Contagem de clientes por cidade e por estado. --
SELECT endereco.estado, COUNT(cliente.cod_cliente) 
FROM endereco
JOIN cliente ON endereco.cod_endereco = cliente.cod_cliente
GROUP BY endereco.estado;

-- Existem clientes sem endereço associado? --
SELECT cliente.nome, cliente.sobrenome
FROM cliente
LEFT JOIN endereco ON cliente.cod_endereco = endereco.cod_endereco
WHERE endereco.cod_endereco IS NULL;

-- Exercícios 3 --
-- Qual livro foi mais emprestado? --
SELECT livro.titulo, COUNT(emprestimo.cod_livro) AS total_livros
FROM livro
JOIN emprestimo ON livro.cod_livro = emprestimo.cod_livro
GROUP BY livro.titulo
ORDER BY total_livros DESC;

-- Qual cliente mais realizou empréstimos? --
SELECT cliente.cod_cliente, COUNT(emprestimo.cod_cliente) AS total_livros
FROM cliente
JOIN emprestimo ON cliente.cod_cliente = emprestimo.cod_cliente
GROUP BY cliente.cod_cliente
ORDER BY total_livros DESC;

-- Quantos empréstimos estão em aberto (data_devolucao é NULL)? --
SELECT COUNT(*) AS emprestimos_em_aberto
FROM emprestimo
WHERE data_devolucao IS NULL;

-- Quais empréstimos estão atrasados (data_dev_prevista passou e data_devolucao ainda é NULL)? --
SELECT cod_cliente, COUNT(*) AS emprestimos_em_aberto
FROM emprestimo
WHERE data_devolucao IS NULL OR data_devolucao > data_dev_prevista
GROUP BY cod_cliente;

-- Qual a duração média dos empréstimos (em dias)? (OBS: Dentro do prazo <= 0 || Fora do prazo > 0) --
SELECT AVG(TIMESTAMPDIFF(DAY, data_dev_prevista, data_devolucao)) AS media_diferenca_dias
FROM emprestimo
WHERE data_devolucao IS NOT NULL;]

-- Quais livros foram emprestados por um cliente específico? --
SELECT cliente.cod_cliente, livro.titulo
FROM emprestimo
JOIN livro ON emprestimo.cod_livro = livro.cod_livro
JOIN cliente ON emprestimo.cod_cliente = cliente.cod_cliente
WHERE cliente.cod_cliente  = 1;

-- Quantos empréstimos foram feitos em um determinado mês/ano? --
SELECT COUNT(cod_emprestimo)
FROM emprestimo
WHERE data_emprestimo >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY);

-- Exercícios 4 --
-- Quais autores têm livros atualmente emprestados? --
SELECT autor.nome, livro.titulo
FROM autor
JOIN livro ON autor.cod_autor = livro.cod_autor;

-- Quais livros estão com membros de um estado específico? --
SELECT livro.titulo, endereco.estado
FROM emprestimo
JOIN livro ON emprestimo.cod_livro = livro.cod_livro
JOIN cliente ON emprestimo.cod_cliente = cliente.cod_cliente
JOIN endereco ON cliente.cod_endereco = endereco.cod_endereco
WHERE endereco.estado LIKE 'SP';

-- Quais clientes já emprestaram livros de um autor específico? --
SELECT DISTINCT autor.nome AS autor, cliente.nome AS cliente
FROM emprestimo
JOIN livro ON emprestimo.cod_livro = livro.cod_livro
JOIN autor ON livro.cod_autor = autor.cod_autor
JOIN cliente ON emprestimo.cod_cliente = cliente.cod_cliente
WHERE autor.nome = 'Machado de Assis';

-- Qual a editora dos livros com maior atraso na devolução? --
SELECT livro.editora, COUNT(*) AS total_atrasos
FROM emprestimo
JOIN livro ON emprestimo.cod_livro = livro.cod_livro
WHERE data_devolucao > data_dev_prevista
GROUP BY livro.editora
ORDER BY total_atrasos DESC
LIMIT 1;

-- Quais clientes nunca fizeram um empréstimo? --
SELECT COUNT(*) AS total_sem_emprestimo
FROM cliente
LEFT JOIN emprestimo ON cliente.cod_cliente = emprestimo.cod_cliente
WHERE emprestimo.cod_emprestimo IS NULL;
