USE biblioteca;

-- Exercicios 1 --
SELECT autor.nome, COUNT(livro.cod_autor) AS numero_livros
FROM livro
JOIN autor ON autor.cod_autor = livro.cod_autor
GROUP BY autor.nome
ORDER BY numero_livros DESC
LIMIT 5;

SELECT editora, COUNT(cod_livro) AS total_livros, AVG(ano) media_livros 
FROM livro
GROUP BY editora
ORDER BY total_livros DESC;

SELECT nome, TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade_atual
FROM autor
HAVING idade_atual <= 100;

SELECT autor.nome, livro.titulo, autor.nacionalidade
FROM livro 
LEFT JOIN autor ON autor.cod_autor = livro.cod_autor
WHERE nacionalidade LIKE '%Britânica%';

-- Exercícios 2 --
SELECT endereco.estado, COUNT(cliente.cod_cliente) AS total_clientes
FROM endereco
JOIN cliente ON endereco.cod_endereco = cliente.cod_endereco
GROUP BY endereco.estado;

SELECT cliente.nome, cliente.sobrenome, endereco.bairro, endereco.cidade
FROM cliente
JOIN endereco ON cliente.cod_endereco = endereco.cod_endereco
WHERE endereco.bairro LIKE 'copacabana'
AND endereco.cidade LIKE 'Rio de janeiro';

SELECT endereco.estado, COUNT(cliente.cod_cliente) 
FROM endereco
JOIN cliente ON endereco.cod_endereco = cliente.cod_cliente
GROUP BY endereco.estado;

SELECT endereco.cidade, COUNT(cliente.cod_cliente) 
FROM endereco
JOIN cliente ON endereco.cod_endereco = cliente.cod_cliente
GROUP BY endereco.cidade;

SELECT cliente.nome, cliente.sobrenome
FROM cliente
LEFT JOIN endereco ON cliente.cod_endereco = endereco.cod_endereco
WHERE endereco.cod_endereco IS NULL;
