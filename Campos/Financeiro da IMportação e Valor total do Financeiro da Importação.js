$sql.select("AD_TIP_TRANSP","AD_FINIMP", "IDFINIMP =" +$col_IDFINIMP +" AND CODPROJ ="+$col_CODPROJ);
if($sql.next()){
TP = $sql.getString(1);
                    
                  if("S".equals(TP) && $col_AD_REF_IMPORT==null){
           throw new IllegalArgumentException("Para Financeiros Diferentes de Pagamento, Não devem ser faturados!");
}}
return $col_AD_REF_IMPORT;





SELECT SUM(FIP.VLRDESDOB) AS VLR
FROM AD_FINIMP FIP
WHERE FIP.CODPROJ = TCSPRJ.CODPROJ