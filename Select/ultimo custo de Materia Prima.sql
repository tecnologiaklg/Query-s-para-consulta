SELECT 
                    DDD.CODPROD,
                    PRO.DESCRPROD,
                    CUS.CUSREP
                    FROM TGFCUS CUS,
                        (SELECT 
                        MAX (EEE.DTATUAL) AS DATA,
                        EEE.CODPROD
                        FROM TGFCUS EEE
                        GROUP BY
                        EEE.CODPROD
                        ) DDD
                    LEFT JOIN TGFPRO PRO ON PRO.CODPROD = DDD.CODPROD
                    WHERE
                    DDD.CODPROD = CUS.CODPROD
                    AND DDD.DATA = CUS.DTATUAL
                    AND PRO.USOPROD = 'M'