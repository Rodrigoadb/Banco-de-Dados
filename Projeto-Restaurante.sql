--Ferramentas/opcoes/Editor de Texto/Todos os Idiomas/Numeros de Linha
USE master;
IF DB_ID('Restaurante') IS NOT NULL
   DROP   DATABASE Restaurante
   CREATE DATABASE Restaurante;
Go
USE Restaurante;
---------------------------------------------------------------
Create Table Fornecedor (Cod_Fornecedor Integer Identity(70,1) Primary key,
                         Descricao      Varchar(40)  NOT NULL,
                         Tipo           Varchar(16)  NOT NULL);
---------------------------------------------------------------
Create Table Cargo (Cod_Cargo Integer Primary Key,
                    Descricao Varchar(40)  NOT NULL);
---------------------------------------------------------------
Create Table Cardapio (Nr_Cardapio Integer Primary Key,
		               Nome        Varchar(40)  NOT NULL,
                       Descricao   Varchar(40)  NOT NULL,
                       Preco       Money);
---------------------------------------------------------------
Create Table Mesa (Nr_Mesa     Integer Primary Key,
                   Localização Char(20)  NOT NULL,
                   Status      Char(12));
---------------------------------------------------------------
Create Table Cliente (Cod_Cliente Integer Identity(100,1) Primary Key,
                      Nome        Varchar(30) NOT NULL,
                      CPF         Char(11) NOT NULL);
---------------------------------------------------------------
Create Table Produto (Cod_Produto        Integer identity(50,1) Primary Key,
                      Descricao          Varchar(40)  NOT NULL,
                      Preco              Money,
                      Estoque_Atual      Integer,
                      Estoque_minimo     Integer);
---------------------------------------------------------------
Create Table Tipo (Cod_Tipo Integer Primary Key,
                   Descricao Varchar(30));
---------------------------------------------------------------
Create Table Conta (Nr_Conta    Integer Identity(70,1) Primary Key,
                    Data        Date     NOT NULL,
                    Hora        Time(0)  NOT NULL,
                    Cod_Cliente Integer References Cliente(Cod_Cliente));
---------------------------------------------------------------
Create Table Funcionario (Matricula   Integer Primary Key,
                          Nome        Varchar(30) NOT NULL,
                          Logradouro  Varchar(30) NOT NULL,
                          Número      Varchar(8)  NOT NULL,
                          Complemento Varchar(40),
                          CEP         Char(8)     NOT NULL,
                          Bairro      Varchar(30) NOT NULL,
                          Cidade      Varchar(30) NOT NULL,
                          Estado      char(2)     NOT NULL,
                          Telefone    Integer     NOT NULL,
                          Email       Varchar(40) NOT NULL,
                          Cod_Cargo   Integer References Cargo(Cod_Cargo));
---------------------------------------------------------------
Create Table Produto_Fornecedor (Cod_Produto    Integer References Produto(Cod_Produto),
                                 Cod_Fornecedor Integer References Fornecedor(Cod_Fornecedor),
								 Data_Entrega   Date NOT NULL,
								 Hora_Entrega   Time(0) NOT NULL,
								 Primary Key(Cod_Produto,Cod_Fornecedor));
---------------------------------------------------------------
Create Table Cardapio_Produto (Nr_Cardapio     Integer References Cardapio(Nr_Cardapio),
				               Cod_Produto     Integer References Produto(Cod_Produto),
				               Quantidade      Integer,
				               Preco           Money,
							   primary key (Nr_Cardapio,Cod_Produto));
---------------------------------------------------------------
Create Table Pagamento (Cod_Pagamento Integer identity(40,1) Primary Key,
			            Data          Date           NOT NULL,
			            Hora          Time(0)        NOT NULL,
						Valor         Money          NOT NULL,
			            Nr_Conta      Integer        References Conta(Nr_Conta),
			            Cod_Tipo      Integer        References Tipo(Cod_Tipo),
						Descricao     Char(8)NOT NULL);
---------------------------------------------------------------
Create Table Pix (Tipo Varchar(30) Primary Key,
                  Chave Varchar(30),
                  Descricao  Varchar(30) NOT NULL,
				  Cod_Pagamento Integer References Pagamento(Cod_Pagamento));
---------------------------------------------------------------
Create Table Cartao (Nr_Cartao        VarChar(19) Primary Key,
		             Nome_Titular     Varchar(30) NOT NULL,
		             Data_Validade    Date        NOT NULL,
		             Codigo_Segurança Char(3)  NOT NULL,
					 Cod_Pagamento Integer References Pagamento(Cod_Pagamento));
---------------------------------------------------------------
Create Table Pedido (Nr_Pedido   Integer identity(95,1) Primary Key,
			         Data        Date,
			         Hora        Time(0),
			         Matricula   Integer References Funcionario(Matricula),
			         Nr_Conta    Integer References Conta(Nr_Conta),
			         Nr_Mesa     Integer References Mesa(Nr_Mesa),
					 Observacao  Varchar(40),
					 Valor_Obs   Money);
---------------------------------------------------------------
Create Table Pedido_Cardapio (Nr_Pedido   Integer References Pedido(Nr_Pedido),
				              Nr_Cardapio Integer References Cardapio(Nr_Cardapio),
				              Quantidade  Integer,
				              Preço       Money,
							  primary key (Nr_Pedido,Nr_Cardapio));
---------------------------------------------------------------
insert into Fornecedor (Descricao,Tipo)
values ('Distribuidora_X','Arroz'),
	   ('Distribuidora_Y','Batata_Frita'),
	   ('Distribuidora_Z','Refrigerante');
---------------------------------------------------------------
insert into Cargo (Cod_Cargo,Descricao)
values (1, 'Garçom'),
       (2, 'Recepcionista'),
	   (3, 'Gerente');
---------------------------------------------------------------
insert into Cardapio (Nr_Cardapio,Nome,Descricao,Preco)
values (01,'Galeto_Completo','Serve 3 Pessoas',85),
	   (02,'Filé_Parmegiana','Serve 3 Pessoas',80),
	   (03,'Isca_de_Peixe','Serve 3 Pessoas',70);
---------------------------------------------------------------
insert into Mesa (Nr_Mesa,Localização,Status)
values (01,'interno','Ocupado'),
       (02,'interno','Reservado'),
	   (03,'externo','Disponível'),
	   (04,'externo','Indisponível');
---------------------------------------------------------------
insert into Cliente (Nome,CPF)
values ('Jorge Alexandre',12345678912),
       ('Henrique Costa',12345678913),
	   ('Maria Clara',12345678914),
	   ('João Pedro',12345678915);
---------------------------------------------------------------
insert into Produto (Descricao,Preco,Estoque_Atual,Estoque_minimo)
values ('Arroz',5.98,35,30),
       ('Batata_Frita',7.19,30,25),
	   ('Refrigerante',8,50,40);
---------------------------------------------------------------
insert into Tipo (Cod_Tipo,Descricao)
values (01,'Dinheiro'),
       (02,'Pix'),
	   (03,'Cartão');
---------------------------------------------------------------
insert into Conta (Data,Hora,Cod_Cliente)
values ('13/12/2022','13:40',100),
	   ('16/12/2022','17:45',101),
	   ('20/12/2022','18:30',102),
	   ('20/12/2022','15:10',103);
---------------------------------------------------------------
insert into Funcionario (Matricula,Nome,Logradouro,Número,Complemento,CEP,Bairro,Cidade,Estado,Telefone,Email,Cod_Cargo)
values (01,'Julia','Rua Alegria',25,'Casa',51150199,'Imbiribeira','Recife','PE',989866118,'julia_roberts@gmail.com',2),
       (02,'Ryan','Rua Alexandrino',10,'Casa',52070440,'Casa Amarela','Recife','PE',986281974,'ryan_reynolds@hotmail.com',1),
	   (03,'Sarah','Vila Asa Branca',57,'Apartamento',50640400,'Torrões','Recife','PE',972855731,'sarah_silverman@outlook.com',3);
---------------------------------------------------------------
insert into Produto_Fornecedor (Cod_Produto,Cod_Fornecedor,Data_Entrega,Hora_Entrega)
values (50,70,'20/12/2022','19:30'),
       (51,71,'20/12/2022','08:50'),
	   (52,72,'21/12/2022','12:00');
---------------------------------------------------------------
insert into Cardapio_Produto (Nr_Cardapio,Cod_Produto,Quantidade,Preco)
values (01,50,1,6.50),
       (02,51,1,8),
	   (03,52,1,8.50);
---------------------------------------------------------------
insert into Pagamento (Data,Hora,Valor,Nr_Conta,Cod_Tipo,Descricao)
values ('21/12/2022','10:45',90,70,01,'Pago'),
       ('21/12/2022','15:30',85,71,03,'Pendente'),
	   ('21/12/2022','14:20',80,72,03,'Pago'),
	   ('21/12/2022','14:16',90,73,02,'Pago');
---------------------------------------------------------------
insert into Pix (Tipo,Chave,Descricao,Cod_Pagamento)
values ('Celular','98114-3603','Ok',40),
       ('Email','jessica_biel@hotmail.com','Ok',41),
	   ('CPF','12345678914','Ok',42);
---------------------------------------------------------------
insert into Cartao (Nr_Cartao,Nome_Titular,Data_Validade,Codigo_Segurança,Cod_Pagamento)
values ('5526 1263 1016 7181','Guilherme B. BARBOSA','21/07/2024','594',40),
       ('5100 2833 0437 6791','CAROLINA M.A. DA ROSA','21/12/2023','326',41),
	   ('5184 8277 2729 0564','RENATA M.I. MONTEIRO','21/09/2023','438',42);
---------------------------------------------------------------
insert into Pedido (Data,Hora,Matricula,Nr_Conta,Nr_Mesa,Observacao,Valor_Obs)
values ('21/12/2022','09:10',01,70,01,'mais 1 porção de Fritas',8),
       ('21/12/2022','15:40',01,71,02,'mais 1 porção de Fritas',8),
	   ('21/12/2022','19:00',01,72,03,'mais 1 porção de Fritas',8);
---------------------------------------------------------------
insert into Pedido_Cardapio (Nr_Pedido,Nr_Cardapio,Quantidade,Preço)
values (95,01,01,85),
       (96,02,01,80),
	   (97,03,01,75);
Select * From Pedido;