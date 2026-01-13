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
                    )CCC ON EST.CODPROD = CCC.CODPROD AND CCC.CONTROLE = EST.CONTROLE