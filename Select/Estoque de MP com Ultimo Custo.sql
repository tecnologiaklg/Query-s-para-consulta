SELECT
PRO.CODPROD,
PRO.DESCRPROD,
CCT.CUSREP
FROM
TGFPRO PRO
LEFT JOIN (SELECT
    PRO.CODPROD,
    CCC.CUSREP
    FROM
    TGFPRO PRO 
    LEFT JOIN (SELECT 
                DDD.CODPROD,
                CUS.CUSREP
                FROM TGFCUS CUS,
                    (SELECT 
                    MAX (EEE.DTATUAL) AS DATA,
                    EEE.CODPROD
                    FROM TGFCUS EEE
                    GROUP BY
                    EEE.CODPROD) DDD
                WHERE
                DDD.CODPROD = CUS.CODPROD
                AND DDD.DATA = CUS.DTATUAL)CCC ON PRO.CODPROD = CCC.CODPROD
                WHERE PRO.USOPROD = 'M' AND PRO.AD_COD_EX IS NULL) CCT ON PRO.CODPROD = CCT.CODPROD
WHERE
PRO.USOPROD = 'M' 