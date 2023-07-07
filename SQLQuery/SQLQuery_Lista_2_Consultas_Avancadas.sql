-- Exercício 2989
SELECT d.nome AS Departamento, 
       dv.nome AS Divisao, 
       AVG(v.valor) AS Media_Salarial, 
       MAX(v.valor) AS Maior_Salario
FROM Empregado e
JOIN Departamento d ON e.lotacao = d.cod_dep
JOIN Divisao dv ON e.lotacao_div = dv.cod_divisao
JOIN Emp_venc ev ON e.matr = ev.matr
JOIN Vencimento v ON ev.cod_venc = v.cod_venc
GROUP BY d.nome, dv.nome
ORDER BY AVG(v.valor) DESC;

-- Exercício 2991
SELECT d.nome AS Departamento, 
       COUNT(e.matr) AS Quantidade_Empregados, 
       AVG(v.valor) AS Media_Salarial, 
       MAX(v.valor) AS Maior_Salario, 
       MIN(v.valor) AS Menor_Salario
FROM Empregado e
JOIN Departamento d ON e.lotacao = d.cod_dep
JOIN Emp_venc ev ON e.matr = ev.matr
JOIN Vencimento v ON ev.cod_venc = v.cod_venc
GROUP BY d.nome
ORDER BY AVG(v.valor) DESC;

-- Exer´cicio 2992
SELECT D.nome AS Departamento, DV.nome AS Divisao, AVG(E.gerencia_cod_dep) AS MediaSalarial
FROM Departamento D
INNER JOIN Divisao DV ON D.cod_dep = DV.cod_dep
INNER JOIN Empregado E ON DV.cod_divisao = E.lotacao_div
GROUP BY D.nome, DV.nome
ORDER BY MediaSalarial DESC;

-- Exerecício 2997
SELECT d.nome as departamento, 
       dv.nome as divisao, 
       e.nome as empregado, 
       SUM(v.valor) as salario_bruto, 
       SUM(COALESCE(descontos.valor, 0)) as total_descontos,
       SUM(v.valor) - SUM(COALESCE(descontos.valor, 0)) as salario_liquido
FROM Empregado e
INNER JOIN Divisao dv ON e.lotacao_div = dv.cod_divisao
INNER JOIN Departamento d ON dv.cod_dep = d.cod_dep
LEFT JOIN Emp_venc ev ON e.matr = ev.matr
LEFT JOIN Vencimento v ON ev.cod_venc = v.cod_venc
LEFT JOIN Emp_desc ed ON e.matr = ed.matr
LEFT JOIN Desconto descontos ON ed.cod_desc = descontos.cod_desc
GROUP BY d.nome, dv.nome, e.nome
ORDER BY d.nome, dv.nome, salario_liquido DESC

-- Exercício 2999
SELECT e.nome, (v.valor * (1 - d.valor_imposto)) as salario_liquido
FROM Empregado e
JOIN Vencimento v ON e.lotacao_div = v.cod_venc
JOIN Divisao dv ON e.lotacao_div = dv.cod_divisao
JOIN Departamento d ON dv.cod_dep = d.cod_dep
WHERE (v.valor * (1 - d.valor_imposto)) > 
      (SELECT AVG(v2.valor * (1 - d2.valor_imposto)) 
       FROM Empregado e2
       JOIN Vencimento v2 ON e2.lotacao_div = v2.cod_venc
       JOIN Divisao dv2 ON e2.lotacao_div = dv2.cod_divisao
       JOIN Departamento d2 ON dv2.cod_dep = d2.cod_dep
       WHERE e2.lotacao_div = e.lotacao_div)
ORDER BY salario_liquido DESC
