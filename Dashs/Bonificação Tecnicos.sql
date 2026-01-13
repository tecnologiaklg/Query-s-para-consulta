SELECT
CAB.VLRNOTA,
CAB.AD_DESP_AT,
CAB.VLRFRETE,
CCC.CUSTO,
III.VLRIMP

FROM
TGFCAB CAB

/*Retorna o Custo vs Quantidade de Produtos*/
    LEFT JOIN (SELECT
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
    ) CCC ON CAB.NUNOTA = CCC.NUNOTA,

 /*Retorna os Impostos*/
            (SELECT
            DIN.NUNOTA,
            SUM(DIN.VALOR + DIN.VLRDIFALDEST + VLRFCP) AS VLRIMP
            FROM TGFDIN DIN
            GROUP BY
            DIN.NUNOTA
            ) III

WHERE
CAB.NUNOTA = III.NUNOTA
AND CAB.NUNOTA = '72196'