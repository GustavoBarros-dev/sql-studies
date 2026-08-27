-- Projeto: Análise de Dados com SQL
-- Autor: GustavoBarros-dev
-- Descrição: Queries de estudo com SELECT, WHERE, AND, OR e concatenação

-- =====================
-- CRIAÇÃO DA TABELA
-- =====================
DROP TABLE IF EXISTS funcionarios;

CREATE TABLE funcionarios (
  id INTEGER PRIMARY KEY,
  nome TEXT,
  cargo TEXT,
  salario REAL,
  departamento TEXT,
  ativo INTEGER
);

INSERT INTO funcionarios VALUES
(1, 'Ana Silva', 'Analista', 3500, 'TI', 1),
(2, 'Carlos Souza', 'Desenvolvedor', 5000, 'TI', 1),
(3, 'Mariana Lima', 'Gerente', 8000, 'RH', 1),
(4, 'Pedro Costa', 'Assistente', 2000, 'RH', 0),
(5, 'Julia Mendes', 'Analista', 4000, 'Financeiro', 1),
(6, 'Roberto Dias', 'Desenvolvedor', 5500, 'TI', 0),
(7, 'Fernanda Rocha', 'Assistente', 2200, 'Financeiro', 1),
(8, 'Lucas Martins', 'Gerente', 9000, 'TI', 1);

-- =====================
-- DIA 1: SELECT básico
-- =====================
SELECT * FROM funcionarios;

-- =====================
-- DIA 2: SELECT colunas específicas
-- =====================
SELECT nome, cargo, salario FROM funcionarios;

-- =====================
-- DIA 3: WHERE
-- =====================
SELECT nome, salario
FROM funcionarios
WHERE salario > 4000;

-- =====================
-- DIA 4: AND / OR / Concatenação
-- =====================

-- AND: TI e ativos
SELECT nome, cargo, salario
FROM funcionarios
WHERE departamento = 'TI'
AND ativo = 1;

-- OR com concatenação
SELECT nome,
       cargo || ' - ' || departamento AS cargo_departamento
FROM funcionarios
WHERE departamento = 'RH'
OR departamento = 'Financeiro';

-- AND + OR combinados
SELECT nome,
       cargo || ' - ' || departamento AS cargo_departamento,
       salario
FROM funcionarios
WHERE (departamento = 'TI' OR departamento = 'RH')
AND ativo = 1;

-- =====================
-- DIA 5: ORDER BY 
-- =====================

-- ASC: do menor para o maior 
SELECT nome, cargo, salario 
FROM funcionarios
ORDER BY salario ASC;

-- DESC: do maior para o menor
SELECT nome, cargo, salario
FROM funcionarios
ORDER BY salario DESC;

-- Ordenando por texto (alfabético)
SELECT nome, cargo, departamento
FROM funcionarios
ORDER BY nome ASC;

-- WHERE + ORDER BY
SELECT nome, cargo, salario
FROM funcionarios
WHERE ativo = 1
ORDER BY salario DESC;

-- Desafio: TI ordenado por nome
SELECT nome, cargo, salario
FROM funcionarios
WHERE departamento = 'TI'
ORDER BY nome ASC;

-- =====================
-- DIA 6: LIMIT
-- =====================

-- LIMIT básico
SELECT nome, cargo, salario
FROM funcionarios
LIMIT 3;

-- TOP 3 maiores salários
SELECT nome, cargo, salario
FROM funcionarios
ORDER BY salario DESC
LIMIT 3;

-- TOP 3 maiores salários entre ativos
SELECT nome, cargo, salario
FROM funcionarios
WHERE ativo = 1
ORDER BY salario DESC
LIMIT 3;

-- Desafio: 2 menores salários do Financeiro
SELECT nome, cargo, salario
FROM funcionarios
WHERE departamento = 'Financeiro'
ORDER BY salario ASC
LIMIT 2;

-- =====================
-- DIA 7: GROUP BY
-- =====================

-- Contagem por departamento
SELECT departamento, COUNT(*) AS total_funcionarios
FROM funcionarios
GROUP BY departamento;

-- Média salarial por departamento
SELECT departamento, AVG(salario) AS media_salarial
FROM funcionarios
GROUP BY departamento;

-- Média salarial por departamento (apenas ativos)
SELECT departamento, AVG(salario) AS media_salarial
FROM funcionarios
WHERE ativo = 1
GROUP BY departamento;

-- Desafio: salário máximo por departamento (apenas ativos)
SELECT departamento, MAX(salario) AS salario_maximo
FROM funcionarios
WHERE ativo = 1
GROUP BY departamento;

-- =====================
-- DIA 8: HAVING
-- =====================

-- Departamentos com mais de 2 funcionários
SELECT departamento, COUNT(*) AS total_funcionarios
FROM funcionarios
GROUP BY departamento
HAVING COUNT(*) > 2;

-- Departamentos com média salarial acima de 5000
SELECT departamento, AVG(salario) AS media_salarial
FROM funcionarios
GROUP BY departamento
HAVING AVG(salario) > 5000;

-- Desafio: departamentos com salário máximo > 6000 (apenas ativos)
SELECT departamento, MAX(salario) AS salario_maximo
FROM funcionarios
WHERE ativo = 1
GROUP BY departamento
HAVING MAX(salario) > 6000;

-- =====================
-- DIA 9: JOIN
-- =====================

-- Segunda tabela usada neste dia
DROP TABLE IF EXISTS departamentos;
CREATE TABLE departamentos (
  id INTEGER PRIMARY KEY,
  nome_departamento TEXT,
  gestor TEXT,
  orcamento REAL
);

INSERT INTO departamentos VALUES
(1, 'TI', 'Lucas Martins', 150000),
(2, 'RH', 'Mariana Lima', 80000),
(3, 'Financeiro', 'Julia Mendes', 100000),
(4, 'Marketing', 'Camila Ferreira', 60000);

-- INNER JOIN: só o que existe nas duas tabelas
SELECT f.nome, f.cargo, d.nome_departamento, d.gestor
FROM funcionarios f
INNER JOIN departamentos d
ON f.departamento = d.nome_departamento;

-- LEFT JOIN: traz todos os departamentos, mesmo sem funcionários
SELECT d.nome_departamento, f.nome, f.cargo
FROM departamentos d
LEFT JOIN funcionarios f
ON d.nome_departamento = f.departamento;

-- Desafio: nome, departamento e orçamento, ordenado por orçamento DESC
SELECT f.nome, d.nome_departamento, d.orcamento
FROM funcionarios f
INNER JOIN departamentos d
ON f.departamento = d.nome_departamento
ORDER BY orcamento DESC;

-- =====================
-- DIA 10: MINI-PROJETO FINAL
-- Cenário: Relatório de RH para a diretoria
-- =====================

-- 1. Funcionários ativos, ordenados por salário (maior > menor)
SELECT nome, cargo, departamento, salario
FROM funcionarios
WHERE ativo = 1
ORDER BY salario DESC;

-- 2. Média salarial por departamento + orçamento (via JOIN)
SELECT f.departamento, AVG(f.salario) AS media_salarial, d.orcamento
FROM funcionarios f
INNER JOIN departamentos d
ON f.departamento = d.nome_departamento
WHERE f.ativo = 1
GROUP BY f.departamento;

-- 3. Departamentos com mais de 1 funcionário ativo, ordenado pela quantidade
SELECT departamento, COUNT(*) AS total_funcionarios
FROM funcionarios
WHERE ativo = 1
GROUP BY departamento
HAVING COUNT(*) > 1
ORDER BY total_funcionarios DESC;