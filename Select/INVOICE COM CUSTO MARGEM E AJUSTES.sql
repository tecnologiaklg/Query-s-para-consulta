SELECT
ITE.CODPROD,
PRO.DESCRPROD,
ITE.QTDNEG,
ITE.VLRUNITMOE,
ITE.AD_VLR_DESC_ADJ_USD,
PRO.MARGLUCRO,
CCC.CUSREP AS ULT_CUSTO



FROM
TGFITE ITE
LEFT JOIN (SELECT 
                DDD.CODPROD,
                CUS.CUSREP
                FROM TGFCUS CUS,
                    (SELECT 
                    MAX (EEE.DTATUAL) AS DATA,
                    EEE.CODPROD
                    FROM TGFCUS EEE
                    GROUP BY
                    EEE.CODPROD
                    ) DDD
                WHERE
                DDD.CODPROD = CUS.CODPROD
                AND DDD.DATA = CUS.DTATUAL
                )CCC ON ITE.CODPROD = CCC.CODPROD,
TGFPRO PRO



WHERE
ITE.CODPROD = PRO.CODPROD
AND ITE.NUNOTA = '62800' /*CÓDIGO DA INVOICE*/