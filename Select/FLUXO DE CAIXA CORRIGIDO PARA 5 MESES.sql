SELECT
ZZZ.MES,
ZZZ.DIAMES,
ZZZ.SALDO_FIN,
ZZZ.SALDO_BANCO,
ZZZ.RECEBIMENTO,
ZZZ.PREVFAT,
ZZZ.FOLHA,
ZZZ.IMPOSTOS,
ZZZ.FIXO,
ZZZ.VARIAV,
ZZZ.VLRIMPORT,
ZZZ.IMPIMPORT,
ZZZ.VLRPROD,
ZZZ.OUTROS,
CASE 
WHEN ZZZ.MES = TO_CHAR(CURRENT_DATE, 'mm-yyyy')                THEN ZZZ.SALDO_FIN + (ZZZ.PREVFAT * 0.195)
WHEN ZZZ.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy') THEN ZZZ.SALDO_FIN + (LAG(ZZZ.PREVFAT, 1, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (ZZZ.PREVFAT * 0.195)                                       + (LAG(ZZZ.PREVFAT, 1, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335)
WHEN ZZZ.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy') THEN ZZZ.SALDO_FIN + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 1, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (ZZZ.PREVFAT * 0.195)                                       + (LAG(ZZZ.PREVFAT, 1, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.19)
WHEN ZZZ.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy') THEN ZZZ.SALDO_FIN + (LAG(ZZZ.PREVFAT, 3, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 3, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (LAG(ZZZ.PREVFAT, 1, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (LAG(ZZZ.PREVFAT, 3, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.19) + (ZZZ.PREVFAT * 0.195) + (LAG(ZZZ.PREVFAT, 1, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.19) + (LAG(ZZZ.PREVFAT, 3, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.275)
WHEN ZZZ.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy') THEN ZZZ.SALDO_FIN + (LAG(ZZZ.PREVFAT, 4, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 3, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 4, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.195) + (LAG(ZZZ.PREVFAT, 3, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (LAG(ZZZ.PREVFAT, 4, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.19) + (ZZZ.PREVFAT * 0.195) + (LAG(ZZZ.PREVFAT, 2, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.335) + (LAG(ZZZ.PREVFAT, 3, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.19) + (LAG(ZZZ.PREVFAT, 4, 0) OVER (ORDER BY ZZZ.DIAMES) * 0.275)
END AS SALDO

FROM
    (SELECT
    CASE 
    WHEN SSS.MES = TO_CHAR(CURRENT_DATE, 'mm-yyyy') THEN SSS.RESULT     
    WHEN SSS.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy') THEN SSS.RESULT + (LAG(SSS.RESULT, 1, 0) OVER (ORDER BY SSS.DIAMES))
    WHEN SSS.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy') THEN SSS.RESULT + (LAG(SSS.RESULT, 2, 0) OVER (ORDER BY SSS.DIAMES)) + (LAG(SSS.RESULT, 1, 0) OVER (ORDER BY SSS.DIAMES))
    WHEN SSS.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy') THEN SSS.RESULT + (LAG(SSS.RESULT, 3, 0) OVER (ORDER BY SSS.DIAMES)) + (LAG(SSS.RESULT, 2, 0) OVER (ORDER BY SSS.DIAMES)) + (LAG(SSS.RESULT, 1, 0) OVER (ORDER BY SSS.DIAMES))
    WHEN SSS.MES = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy') THEN SSS.RESULT + (LAG(SSS.RESULT, 4, 0) OVER (ORDER BY SSS.DIAMES)) + (LAG(SSS.RESULT, 3, 0) OVER (ORDER BY SSS.DIAMES)) + (LAG(SSS.RESULT, 2, 0) OVER (ORDER BY SSS.DIAMES)) + (LAG(SSS.RESULT, 1, 0) OVER (ORDER BY SSS.DIAMES))
    END AS SALDO_FIN,
    SSS.SALDO AS SALDO_BANCO,
    SSS.MES,
    SSS.DIAMES,
    SSS.RECEBIMENTO,
    SSS.PREVFAT,
    SSS.FOLHA,
    SSS.IMPOSTOS,
    SSS.FIXO,
    SSS.VARIAV,
    SSS.OUTROS,
    SSS.VLRIMPORT,
    SSS.IMPIMPORT,
    SSS.VLRPROD
    FROM
        (SELECT
        AAA.SALDO + AAA.RECEBIMENTO - AAA.FIXO - AAA.VARIAV - AAA.OUTROS - NVL(AAA.VLRIMPORT, 0) - NVL(AAA.IMPIMPORT, 0) - AAA.VLRPROD - AAA.IMPOSTOS - AAA.FOLHA AS RESULT,
        AAA.SALDO,
        AAA.MES,
        AAA.DIAMES,
        AAA.RECEBIMENTO,
        AAA.PREVFAT,
        AAA.FOLHA,
        AAA.IMPOSTOS,
        AAA.FIXO,
        AAA.VARIAV,
        AAA.OUTROS,
        NVL(AAA.VLRIMPORT, 0) AS VLRIMPORT,
        NVL(AAA.IMPIMPORT, 0) AS IMPIMPORT,
        AAA.VLRPROD
        FROM


            (SELECT
            SAL.SALDO,
            REC.RECEBIMENTO,
            PFC.PREVFAT,
            PFC.FOLHA,
            PFC.IMPOSTOS,
            FIX.FIXO,
            VRV.VARIAV,
            PFC.OUTROS,
            IPC.VLRIMPORT,
            IPT.VLRIMPORT AS IMPIMPORT,
            PFC.VLRPROD,
            TO_CHAR(PFC.DIAMES, 'mm-yyyy') AS MES,
            PFC.DIAMES
            FROM
            /*RECEBIMENTOS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS RECEBIMENTO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '1'
                AND FIN.PROVISAO = 'N'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')
                AND FIN.DHBAIXA IS NULL) REC,
            /*CONTAS FIXAS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS FIXO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO = 'S'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')) FIX,
            /*CONTAS VARIAVEIS*/
                (SELECT
                SUM(FIN.VLRDESDOB) AS VARIAV
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO IS NULL
                AND FIN.AD_PROVIMPORT IS NULL
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')
                -- REMOVER ESTE FILTRO DE GNRE QAUNDO FOR CONSERTADO
                AND FIN.CODTIPTIT <> '47'
                OR FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO = 'N'
                AND FIN.AD_PROVIMPORT = 'N'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')
                -- REMOVER ESTE FILTRO DE GNRE QAUNDO FOR CONSERTADO
                AND FIN.CODTIPTIT <> '47') VRV,
            /*SALDO BANCARIO*/
            (SELECT
                SUM(SSS.SALDO) AS SALDO
                FROM
                    (SELECT
                        SBC.CODCTABCOINT,
                        SBC.SALDOREAL + NVL(MBC.MOV,0) AS SALDO,
                        TO_CHAR(SBC.REFERENCIA, 'mm-yyyy') AS REFERENCIA
                        FROM TGFSBC SBC
                        LEFT JOIN (SELECT
                            MBC.CODCTABCOINT,  
                            SUM (MBC.VLRLANC * MBC.RECDESP) AS MOV
                            FROM
                            TGFMBC MBC
                            WHERE
                            TO_CHAR(DTLANC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')
                            GROUP BY
                            MBC.CODCTABCOINT) MBC ON MBC.CODCTABCOINT = SBC.CODCTABCOINT
                            WHERE TO_CHAR(SBC.REFERENCIA, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')
                            AND SBC.CODCTABCOINT <> '21') SSS) SAL,
            /*VALORES DE PREVISÕES DO FLUXO DE CAIXA*/
            (SELECT
                (FLX.FOLHA1 + FLX.FOLHA2 + FLX.FOLHA3 + FLX.FOLHA4) AS FOLHA,
                (FLX.IMP1 + FLX.IMP2 + FLX.IMP3 + FLX.IMP4) AS IMPOSTOS,
                FLX.PREVFAT,
                FLX.OUTROS,        
                FLX.VLRPROD,
                FLX.DIAMES
                FROM AD_FLXCAX FLX
                WHERE TO_CHAR(FLX.DIAMES, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')) PFC,
            /*VALOR DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'N' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy') OR
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP IS NULL AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')) IPC,
            /*IMPOSTOS DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'S' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(CURRENT_DATE, 'mm-yyyy')) IPT
            UNION 


            SELECT
            0,
            REC.RECEBIMENTO,
            PFC.PREVFAT,
            PFC.FOLHA,
            PFC.IMPOSTOS,
            FIX.FIXO,
            VRV.VARIAV,
            PFC.OUTROS,
            IPC.VLRIMPORT,
            IPT.VLRIMPORT,
            PFC.VLRPROD,
            TO_CHAR(PFC.DIAMES, 'mm-yyyy') AS MES,
            PFC.DIAMES
            FROM
            /*RECEBIMENTOS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS RECEBIMENTO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '1'
                AND FIN.PROVISAO = 'N'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy')
                AND FIN.DHBAIXA IS NULL) REC,
            /*CONTAS FIXAS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS FIXO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO = 'S'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy')) FIX,
            /*CONTAS VARIAVEIS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VARIAV
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO IS NULL
                AND FIN.AD_PROVIMPORT IS NULL
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy')) VRV,
            /*VALORES DE PREVISÕES DO FLUXO DE CAIXA*/
            (SELECT
                SUM(SALDOREAL) AS SALDO,
                TO_CHAR(REFERENCIA, 'mm-yyyy') AS REFERENCIA
                FROM TGFSBC 
                WHERE TO_CHAR(REFERENCIA, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy')
                GROUP BY REFERENCIA) SAL,
                (SELECT
                (FLX.FOLHA1 + FLX.FOLHA2 + FLX.FOLHA3 + FLX.FOLHA4) AS FOLHA,
                (FLX.IMP1 + FLX.IMP2 + FLX.IMP3 + FLX.IMP4) AS IMPOSTOS,
                FLX.PREVFAT,
                FLX.OUTROS,        
                FLX.VLRPROD,
                FLX.DIAMES
                FROM AD_FLXCAX FLX
                WHERE TO_CHAR(FLX.DIAMES, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy')) PFC,
            /*VALOR DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'N' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy') OR
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP IS NULL AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy')) IPC,
            /*IMPOSTOS DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'S' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 1), 'mm-yyyy')) IPT
            UNION


            SELECT
            0,
            REC.RECEBIMENTO,
            PFC.PREVFAT,
            PFC.FOLHA,
            PFC.IMPOSTOS,
            FIX.FIXO,
            VRV.VARIAV,
            PFC.OUTROS,
            IPC.VLRIMPORT,
            IPT.VLRIMPORT,
            PFC.VLRPROD,
            TO_CHAR(PFC.DIAMES, 'mm-yyyy') AS MES,
            PFC.DIAMES
            FROM
            /*RECEBIMENTOS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS RECEBIMENTO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '1'
                AND FIN.PROVISAO = 'N'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy')
                AND FIN.DHBAIXA IS NULL) REC,
            /*CONTAS FIXAS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS FIXO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO = 'S'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy')) FIX,
            /*CONTAS VARIAVEIS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VARIAV
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO IS NULL
                AND FIN.AD_PROVIMPORT IS NULL
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy')) VRV,
            /*VALORES DE PREVISÕES DO FLUXO DE CAIXA*/
            (SELECT
                SUM(SALDOREAL) AS SALDO,
                TO_CHAR(REFERENCIA, 'mm-yyyy') AS REFERENCIA
                FROM TGFSBC 
                WHERE TO_CHAR(REFERENCIA, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy')
                GROUP BY REFERENCIA) SAL,
                (SELECT
                (FLX.FOLHA1 + FLX.FOLHA2 + FLX.FOLHA3 + FLX.FOLHA4) AS FOLHA,
                (FLX.IMP1 + FLX.IMP2 + FLX.IMP3 + FLX.IMP4) AS IMPOSTOS,
                FLX.PREVFAT,
                FLX.OUTROS,        
                FLX.VLRPROD,
                FLX.DIAMES
                FROM AD_FLXCAX FLX
                WHERE TO_CHAR(FLX.DIAMES, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy')) PFC,
            /*VALOR DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'N' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy') OR
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP IS NULL AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy')) IPC,
            /*IMPOSTOS DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'S' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 2), 'mm-yyyy')) IPT
            UNION

            
            SELECT
            0,
            REC.RECEBIMENTO,
            PFC.PREVFAT,
            PFC.FOLHA,
            PFC.IMPOSTOS,
            FIX.FIXO,
            VRV.VARIAV,
            PFC.OUTROS,
            IPC.VLRIMPORT,
            IPT.VLRIMPORT,
            PFC.VLRPROD,
            TO_CHAR(PFC.DIAMES, 'mm-yyyy') AS MES,
            PFC.DIAMES
            FROM
            /*RECEBIMENTOS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS RECEBIMENTO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '1'
                AND FIN.PROVISAO = 'N'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy')
                AND FIN.DHBAIXA IS NULL) REC,
            /*CONTAS FIXAS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS FIXO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO = 'S'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy')) FIX,
            /*CONTAS VARIAVEIS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VARIAV
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO IS NULL
                AND FIN.AD_PROVIMPORT IS NULL
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy')) VRV,
            /*VALORES DE PREVISÕES DO FLUXO DE CAIXA*/
            (SELECT
                SUM(SALDOREAL) AS SALDO,
                TO_CHAR(REFERENCIA, 'mm-yyyy') AS REFERENCIA
                FROM TGFSBC 
                WHERE TO_CHAR(REFERENCIA, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy')
                GROUP BY REFERENCIA) SAL,
                (SELECT
                (FLX.FOLHA1 + FLX.FOLHA2 + FLX.FOLHA3 + FLX.FOLHA4) AS FOLHA,
                (FLX.IMP1 + FLX.IMP2 + FLX.IMP3 + FLX.IMP4) AS IMPOSTOS,
                FLX.PREVFAT,
                FLX.OUTROS,        
                FLX.VLRPROD,
                FLX.DIAMES
                FROM AD_FLXCAX FLX
                WHERE TO_CHAR(FLX.DIAMES, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy')) PFC,
            /*VALOR DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'N' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy') OR
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP IS NULL AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy')) IPC,
            /*IMPOSTOS DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'S' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 3), 'mm-yyyy')) IPT
            UNION

            SELECT
            0,
            REC.RECEBIMENTO,
            PFC.PREVFAT,
            PFC.FOLHA,
            PFC.IMPOSTOS,
            FIX.FIXO,
            VRV.VARIAV,
            PFC.OUTROS,
            IPC.VLRIMPORT,
            IPT.VLRIMPORT,
            PFC.VLRPROD,
            TO_CHAR(PFC.DIAMES, 'mm-yyyy') AS MES,
            PFC.DIAMES
            FROM
            /*RECEBIMENTOS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS RECEBIMENTO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '1'
                AND FIN.PROVISAO = 'N'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy')
                AND FIN.DHBAIXA IS NULL) REC,
            /*CONTAS FIXAS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS FIXO
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO = 'S'
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy')) FIX,
            /*CONTAS VARIAVEIS*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VARIAV
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1'
                AND FIN.DHBAIXA IS NULL
                AND FIN.AD_CUSTO_FIXO IS NULL
                AND FIN.AD_PROVIMPORT IS NULL
                AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy')) VRV,
            /*VALORES DE PREVISÕES DO FLUXO DE CAIXA*/
            (SELECT
                SUM(SALDOREAL) AS SALDO,
                TO_CHAR(REFERENCIA, 'mm-yyyy') AS REFERENCIA
                FROM TGFSBC 
                WHERE TO_CHAR(REFERENCIA, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy')
                GROUP BY REFERENCIA) SAL,
                (SELECT
                (FLX.FOLHA1 + FLX.FOLHA2 + FLX.FOLHA3 + FLX.FOLHA4) AS FOLHA,
                (FLX.IMP1 + FLX.IMP2 + FLX.IMP3 + FLX.IMP4) AS IMPOSTOS,
                FLX.PREVFAT,
                FLX.OUTROS,        
                FLX.VLRPROD,
                FLX.DIAMES
                FROM AD_FLXCAX FLX
                WHERE TO_CHAR(FLX.DIAMES, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy')) PFC,
            /*VALOR DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'N' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy') OR
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP IS NULL AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy')) IPC,
            /*IMPOSTOS DA IMPORTAÇÃO*/
            (SELECT
                SUM(FIN.VLRDESDOB) AS VLRIMPORT
                FROM TGFFIN FIN
                WHERE
                FIN.RECDESP = '-1' AND FIN.DHBAIXA IS NULL AND FIN.AD_PROVIMPORT = 'S' AND FIN.AD_TXIMP = 'S' AND TO_CHAR(FIN.DTVENC, 'mm-yyyy') = TO_CHAR(ADD_MONTHS(CURRENT_DATE, 4), 'mm-yyyy')) IPT
            
            
            ) AAA
            ORDER BY
            MES) SSS) ZZZ

ORDER BY
ZZZ.DIAMES
