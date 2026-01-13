/*Retorna as Vendas por Periodo*/
SELECT
SUM(CAB.VLRNOTA) AS VLRTOTAL,
CAB.DTMOV AS DIA

FROM
TGFCAB CAB

/*Referência em Pedidos de Venda e Dt de Movimento*/
WHERE
CAB.CODTIPOPER IN ('3101','3102','3104')
AND CAB.DTMOV >= :PERIODO.INI
AND CAB.DTMOV <= :PERIODO.FIN
AND CAB.CODVEND IN :P_CODVEND

GROUP BY 
CAB.DTMOV

/*Ordenar por Dt para não haver erro na ordenação. Cuidado ao trasnformar Dts e texto pois o mesmo pode dar erro na Ordenção*/
ORDER BY
CAB.DTMOV