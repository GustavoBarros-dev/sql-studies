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
