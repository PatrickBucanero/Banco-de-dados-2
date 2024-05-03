--Selecione todos os clientes cujo status seja "bom" e ordene os resultados pelo nome do cliente em ordem alfabética.
--Liste todos os produtos na categoria "Eletrônicos" e ordene pelo nome do produto em ordem alfabética.
--Encontre o valor total de todos os pedidos feitos por clientes com o status "médio".
--Obtenha uma lista de clientes que fizeram pedidos em abril de 2024, ordenada pelo nome do cliente em ordem alfabética.
--Selecione todos os produtos que tenham um valor unitário superior a $100 e ordene os resultados pelo valor unitário em ordem decrescente.
--Encontre o cliente mais novo (em termos de data de nascimento) que tenha feito um pedido.
--Liste todos os produtos em ordem decrescente de quantidade vendida.
--Selecione o nome do cliente e o total gasto por cada cliente, ordenando os resultados pelo total gasto em ordem decrescente.
--Encontre a categoria com o maior número de produtos.






create database EX03
go

use EX03
go

create table Categoria (
	cd_categoria int primary key,
	nm_categoria varchar(50) not null
)

create table Produto (
	cd_produto int primary key,
	nm_produto varchar(100) not null,
	vl_produto money,
	cd_categoria int foreign key references Categoria
)

create table Cliente (
	cd_cliente int primary key,
	nm_cliente varchar(100) not null,
	ds_endereco varchar(150),
	ds_telefone varchar(11),
	sg_status varchar(10) check (sg_status = 'bom' or sg_status = 'médio' or sg_status = 'ruim'),
	dt_nascimento date check (dt_nascimento < getdate()),
	vl_limite money default 0
)

create table Pedido (
	cd_pedido int primary key,
	dt_pedido date default getdate(),
	cd_cliente int foreign key references Cliente
)

create table ItemPedido (	
	cd_produto int foreign key references Produto not null,
	cd_pedido int foreign key references Pedido not null,
	qt_produto int check (qt_produto > 0),
	vl_produto money,	
)
go

alter table ItemPedido
	add primary key (cd_produto, cd_pedido)

go



-- Inserir dados na tabela Categoria
INSERT INTO Categoria (cd_categoria, nm_categoria) VALUES
(1, 'Eletrônicos'),
(2, 'Roupas'),
(3, 'Alimentos'),
(4, 'Móveis'),
(5, 'Livros'),
(6, 'Brinquedos'),
(7, 'Utensílios Domésticos'),
(8, 'Ferramentas'),
(9, 'Produtos de Limpeza'),
(10, 'Acessórios Esportivos');
go

-- Inserir dados na tabela Produto
INSERT INTO Produto (cd_produto, nm_produto, cd_categoria, vl_produto) VALUES
(1, 'Smartphone', 1, 120),
(2, 'Camiseta', 2, 45),
(3, 'Arroz', 3, 56),
(4, 'Sofá', 4, 190),
(5, 'Livro de Ficção', 5, 1212),
(6, 'Quebra-Cabeça', 6, 21),
(7, 'Panela de Pressão', 7, 54),
(8, 'Furadeira', 8, 98),
(9, 'Detergente', 9, 65),
(10, 'Tênis', 10, 90),
(11, 'Gabarito da P2 de Banco de Dados', 10, 5000);
go

-- Inserir dados na tabela Cliente
INSERT INTO Cliente (cd_cliente, nm_cliente, ds_endereco, ds_telefone, sg_status, dt_nascimento, vl_limite) VALUES
(1, 'João da Silva', 'Rua A, 123', '1122334455', 'bom', '1980-05-15', 500.00),
(2, 'Maria Oliveira', 'Av. B, 456', '9988776655', 'médio', '1995-10-20', 300.00),
(3, 'José Santos', 'Rua C, 789', '9988776655', 'ruim', '2000-02-10', 200.00),
(4, 'Ana Pereira', 'Rua D, 321', '1122334455', 'bom', '1975-07-25', 1000.00),
(5, 'Carlos Fernandes', 'Av. E, 654', '9988776655', 'médio', '1988-09-30', 700.00),
(6, 'Amanda Souza', 'Rua F, 987', '1122334455', 'ruim', '1992-04-05', 400.00),
(7, 'Pedro Costa', 'Av. G, 1234', '9988776655', 'bom', '1983-12-12', 800.00),
(8, 'Laura Carvalho', 'Rua H, 567', '1122334455', 'médio', '1997-08-18', 600.00),
(9, 'Roberto Almeida', 'Av. I, 890', '9988776655', 'ruim', '2002-01-08', 300.00),
(10, 'Fernanda Lima', 'Rua J, 1234', '1122334455', 'bom', '1972-03-22', 1200.00),
(11, 'Mariana Rodrigues', 'Av. K, 5678', '9988776655', 'médio', '1985-11-28', 900.00),
(12, 'Ricardo Nunes', 'Rua L, 4321', '1122334455', 'ruim', '1990-06-14', 200.00),
(13, 'Isabela Gomes', 'Av. M, 9876', '9988776655', 'bom', '1978-09-03', 1500.00),
(14, 'Felipe Barbosa', 'Rua N, 345', '1122334455', 'médio', '1993-02-17', 1000.00),
(15, 'Patrícia Lima', 'Av. O, 6543', '9988776655', 'ruim', '1986-07-08', 500.00),
(16, 'Lucas Fernandes', 'Rua P, 9876', '1122334455', 'bom', '1981-01-30', 800.00),
(17, 'Tatiane Almeida', 'Av. Q, 2345', '9988776655', 'médio', '1996-05-12', 600.00),
(18, 'Bruno Oliveira', 'Rua R, 6543', '1122334455', 'ruim', '2001-08-20', 400.00),
(19, 'Luana Pereira', 'Av. S, 8765', '9988776655', 'bom', '1974-04-26', 1300.00),
(20, 'Gustavo Silva', 'Rua T, 3210', '1122334455', 'médio', '1987-10-10', 700.00);
go

-- Inserir dados na tabela Pedido
INSERT INTO Pedido (cd_pedido, dt_pedido, cd_cliente) VALUES
(1, '2024-04-26', 1),
(2, '2024-04-26', 2),
(3, '2024-04-26', 3),
(4, '2024-04-26', 4),
(5, '2024-04-26', 5),
(6, '2024-04-26', 6),
(7, '2024-04-26', 7),
(8, '2024-04-26', 8),
(9, '2024-04-26', 9),
(10, '2024-04-26', 10),
(11, '2024-04-26', 11),
(12, '2024-04-26', 12),
(13, '2024-04-26', 13),
(14, '2024-04-26', 14),
(15, '2024-04-26', 15),
(16, '2024-04-26', 16),
(17, '2024-04-26', 17),
(18, '2024-04-26', 18),
(19, '2024-04-26', 19),
(20, '2024-04-26', 20);
go

-- Inserir dados na tabela ItemPedido
INSERT INTO ItemPedido (cd_produto, cd_pedido, qt_produto, vl_produto) VALUES
(1, 1, 2, 1500.00),
(2, 2, 3, 50.00),
(3, 3, 1, 10.00),
(4, 4, 1, 2000.00),
(5, 5, 1, 30.00),
(6, 6, 1, 20.00),
(7, 7, 1, 100.00),
(8, 8, 1, 150.00),
(9, 9, 2, 5.00),
(10, 10, 2, 100.00),
(1, 11, 3, 1500.00),
(2, 12, 3, 50.00),
(3, 13, 4, 10.00),
(4, 14, 1, 2000.00),
(5, 15, 1, 30.00),
(6, 16, 1, 20.00),
(7, 17, 2, 100.00),
(8, 18, 1, 150.00),
(9, 19, 2, 5.00),
(10, 20, 2, 100.00);




--1
SELECT *
FROM Cliente
WHERE sg_status = 'bom'
ORDER BY nm_Cliente ASC;
go
--2

SELECT nm_Produto
FROM Produto
WHERE cd_categoria = 1
ORDER BY nm_Produto ASC;
go
--3
SELECT SUM(cd_pedido) AS ValorTotalPedidos
FROM Pedido
WHERE cd_cliente IN (
    SELECT cd_cliente
    FROM Cliente
    WHERE sg_status = 'médio'
);
go
--4
SELECT c.nm_cliente
FROM Cliente c, Pedido p
WHERE c.cd_cliente = p.cd_cliente
  AND YEAR(p.dt_pedido) = 2024
  AND MONTH(p.dt_pedido) = 4
ORDER BY c.nm_cliente ASC;
go

--5
SELECT *
FROM produto
WHERE vl_produto > 100
ORDER BY vl_produto DESC;
go
--6
SELECT c.nm_cliente, c.dt_nascimento
FROM cliente c, pedido p
WHERE c.cd_cliente = p.cd_cliente
ORDER BY c.dt_nascimento ASC;
go
--7
SELECT *
FROM ItemPedido
ORDER BY qt_produto DESC;
go

--8
SELECT c.nm_cliente, 
       SUM(p.vl_produto) AS TotalGasto
FROM Cliente c, Pedido ped, Produto p
WHERE c.cd_cliente = ped.cd_cliente
  AND ped.cd_pedido = p.cd_categoria
GROUP BY c.cd_cliente, c.nm_cliente
ORDER BY TotalGasto DESC;
--9
SELECT cd_categoria, COUNT(*) AS num_produtos
FROM produto
GROUP BY cd_categoria
ORDER BY num_produtos DESC
go
--10
SELECT *
FROM Produto p 
WHERE p.cd_produto not in(
SELECT ip.cd_produto
FROM ItemPedido ip
)
go