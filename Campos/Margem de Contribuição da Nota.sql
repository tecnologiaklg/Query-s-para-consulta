#type.sql#
SELECT
CASE
WHEN AAA.CUSTO IS NULL OR AAA.CUSTO ='0' THEN 0 
ELSE SUM((AAA.VLRNOTA - AAA.VLRFRETE - AAA.AD_FRETE_KLG - AAA.CUSTO - AAA.VLRIMP) / AAA.VLRNOTA * 100) 
END AS MC

FROM 
/*Criação de uma View para trazer os resultados ja pré-selecionados*/
    (SELECT
    CAB.CODEMP,
    CAB.NUNOTA,
    CAB.VLRNOTA,
    CAB.VLRFRETE,
    CAB.AD_FRETE_KLG,
    III.VLRIMP,
    CCC.CUSTO

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

    ) AAA

WHERE
AAA.NUNOTA = TGFCAB.NUNOTA

GROUP BY
AAA.CUSTO