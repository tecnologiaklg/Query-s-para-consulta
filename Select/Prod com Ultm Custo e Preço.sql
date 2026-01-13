SELECT
PRO.CODPROD,
PRO.DESCRPROD,
CC2.CUSREP,
PPP.VLRVENDA

FROM
TGFPRO PRO
/*Retorna o Custo*/
            LEFT JOIN (SELECT 
                    DDD.CONTROLE,
                    DDD.CODPROD,
                    CUS.CUSREP
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
                    )CC2 ON PRO.CODPROD = CC2.CODPROD AND CC2.CONTROLE = '13380001'
                    
                    LEFT JOIN (SELECT 
                    DDD.CONTROLE,
                    DDD.CODPROD,
                    EXC.VLRVENDA
                    FROM TGFEXC EXC,
                        (SELECT 
                        MAX (EEE.NUTAB) AS TAB,
                        EEE.CONTROLE,
                        EEE.CODPROD
                        FROM TGFEXC EEE
                        GROUP BY
                        EEE.CONTROLE,
                        EEE.CODPROD
                        ) DDD
                    WHERE
                    DDD.CONTROLE = EXC.CONTROLE
                    AND DDD.CODPROD = EXC.CODPROD
                    AND DDD.TAB = EXC.NUTAB
                    )PPP ON PRO.CODPROD = PPP.CODPROD AND PPP.CONTROLE = '13380001'
                    
WHERE
PRO.AD_COD_EX IS NOT NULL
