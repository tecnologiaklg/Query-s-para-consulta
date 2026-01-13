SELECT
TAB.CODVEND,
SUM(TAB.VLRNOTA) AS VENDA,
AVG(TAB.MC) AS MARGEN

FROM
(SELECT
CAB.NUNOTA,
CAB.VLRNOTA,
CAB.CODVEND,
CAB.AD_NUM_OS,
MGC.MC


FROM
TGFCAB CAB
LEFT JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
LEFT JOIN (SELECT
    CASE
    WHEN AAA.CODTIPOPER = '3250' THEN ((AAA.VLRNOTA - (AAA.VLRNOTA * 0.1604) - AAA.AD_DESP_AT) / AAA.VLRNOTA) * 100
    WHEN AAA.CODTIPOPER IN ('3200','3205','3262') THEN (AAA.VLRNOTA - AAA.VLRFRETE - AAA.CUSTO - AAA.VLRIMP) / AAA.VLRNOTA * 100 
    ELSE NULL END AS MC,
    AAA.NUNOTA
    FROM 
    /*Criação de uma View para trazer os resultados ja pré-selecionados*/
        (SELECT
        CAB.CODEMP,
        CAB.NUNOTA,
        CAB.VLRNOTA,
        CAB.VLRFRETE,
        NVL(CAB.AD_DESP_AT,0) AS AD_DESP_AT,
        CAB.CODTIPOPER,
        III.VLRIMP,
        NVL(CCC.CUSTO,0) AS CUSTO
        FROM 
        TGFCAB CAB,
        /*Retorna o Custo*/
        (SELECT
    CC3.NUNOTA,
    SUM(CC3.CALC) AS CUSTO
    FROM
    (SELECT
        ITE.NUNOTA,
        (CC2.CUSGER * ITE.QTDNEG) AS CALC
        FROM
        TGFITE ITE
        /*Retorna o Custo*/
        LEFT JOIN (SELECT 
                DDD.CONTROLE,
                DDD.CODPROD,
                CUS.CUSGER
                FROM TGFCUS CUS,
                    (SELECT 
                    MAX (EEE.DTATUAL) AS DATA,
                    EEE.CONTROLE,
                    EEE.CODPROD
                    FROM TGFCUS EEE
                    GROUP BY
                    EEE.CONTROLE,
                    EEE.CODPROD
                    ) DDD
                WHERE
                DDD.CONTROLE = CUS.CONTROLE
                AND DDD.CODPROD = CUS.CODPROD
                AND DDD.DATA = CUS.DTATUAL
                )CC2 ON ITE.CODPROD = CC2.CODPROD AND ITE.CONTROLE = CC2.CONTROLE
        )CC3
        GROUP BY
        CC3.NUNOTA
        ) CCC,
        /*Retorna os Impostos*/
            (SELECT
            DIN.NUNOTA,
            SUM(DIN.VALOR + DIN.VLRDIFALDEST + VLRFCP) AS VLRIMP
            FROM
            TGFDIN DIN
            GROUP BY
            DIN.NUNOTA
            ) III
        WHERE
        CAB.NUNOTA = CCC.NUNOTA
        AND CAB.NUNOTA = III.NUNOTA
        AND CAB.CODTIPOPER IN ('3200','3205','3262','3250')
        ) AAA
        ) MGC ON CAB.NUNOTA = MGC.NUNOTA


WHERE
VEN.AD_UNIDADE = '3'
AND CAB.DTNEG BETWEEN :PERIODO.INI AND :PERIODO.FIN
AND CAB.CODTIPOPER IN ('3200','3205','3250','3262')
) TAB

GROUP BY
TAB.CODVEND