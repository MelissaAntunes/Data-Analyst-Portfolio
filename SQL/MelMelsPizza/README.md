 [![View Repositories](https://img.shields.io/badge/View-My_Repositories-blue?logo=GitHub)](https://github.com/MelissaAntunes?tab=repositories)
[![View My Profile](https://img.shields.io/badge/View-My_Profile-green?logo=GitHub)](https://github.com/MelissaAntunes) 

<p align="center">
<img src="https://github.com/MelissaAntunes/Data-Analyst-Portfolio/blob/main/SQL/MelMelsPizza/images/melmelspizza-banner.png" width=80% height=80%>
	
### História da MelMel's Pizza

No início de 2024, Melissa, uma jovem empreendedora apaixonada por culinária italiana, decidiu realizar seu sonho de abrir sua própria pizzaria. Após anos de trabalho em restaurantes renomados e uma temporada estudando gastronomia na Itália, Melissa inaugurou a MelMel's Pizza, situada nas cidades de São Paulo, Osasco e Guarulhos.

<img src="https://github.com/MelissaAntunes/Data-Analyst-Portfolio/blob/main/SQL/MelMelsPizza/images/melmelspizza-menu.png" width=80% height=80%>

- total de pedidos
- total de vendas
- total de itens
- valor médio de pedido
- top pizza vendidas
- quantidade de pedidos por dia
- pedidos por cidade
- pedidos por delivery/pick up

```sql
-- consulta necessária para o dashboard
SELECT
	pedidos.id_pedido,
    item.preco_item,
    pedidos.quantidade,
    item.nome_item,
    pedidos.criado_em,
    endereco.delivery_end1,
    endereco.delivery_cidade,
    endereco.delivery_codpost,
    pedidos.delivery
FROM pedidos
LEFT JOIN endereco
	ON endereco.ende_id = pedidos.ende_id
LEFT JOIN item
	ON item.id_item = pedidos.id_item;
```

<img src="https://github.com/MelissaAntunes/Data-Analyst-Portfolio/blob/main/SQL/MelMelsPizza/dashboard.png" width=80% height=80%>

### Atividade da MelMel's Pizza na Primeira Semana de Inauguração

A MelMel's Pizza abriu suas portas no dia 1º de julho de 2024. Apesar da primeira semana não ter atingido as expectativas, Melissa não se deixou desanimar ou considerar desistir de suas pizzarias.

### Dias 1 e 2: Inauguração (1 e 2 de julho)

Nos dois primeiros dias, o número de pedidos foi relativamente baixo, o que Melissa não esperava, pois achava que uma nova pizzaria atrairia a atenção das pessoas.

### Dias 3 e 4: (3 e 4 de julho)

No terceiro dia, o número de pedidos teve um aumento relativamente alto em comparação com os dois primeiros dias, mas logo diminuiu no quarto dia.

### Resumo da Primeira Semana:

- **Total de pizzas vendidas:** 24
- **Sabor de Pizza:** O sabor mais vendido foi a Pizza de Frango com Catupiry, seguido pela Pizza de Calabresa.
- **Cidades:** A maior concentração de pedidos está na cidade de São Paulo.
- **Serviço de delivery:** Apenas 37,5% dos pedidos foram feitos por delivery; 62,5% preferiram buscar o pedido pessoalmente.

### RECOMENDAÇÕES

- Focar no marketing da pizzaria. Uma presença online ajudaria na divulgação e, consequentemente, o conhecimento sobre a nova pizzaria chegaria a mais pessoas.
- Diminuir as opções de pizza do menu durante os primeiros meses de inauguração e adicionar mais opções de acordo com a frequência e quantidade de clientes.
- Adicionar variações ao menu, como bebidas e sobremesas.
- Promoções podem ajudar a atrair mais clientes.
- 
<img src="https://github.com/MelissaAntunes/Data-Analyst-Portfolio/blob/main/SQL/MelMelsPizza/images/QuickDBD-export.png" width=80% height=80%>
