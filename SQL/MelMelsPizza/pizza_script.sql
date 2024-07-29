-- Dashboard 1
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
