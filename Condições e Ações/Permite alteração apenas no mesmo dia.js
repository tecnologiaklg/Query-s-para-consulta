// Define os parâmetros principais
$sql.setParam("ID", $col_ID);
$sql.setParam("SEQ", $col_SEQ);

// Consulta a data de inclusão
$sql.select("DH_INC, CODPARC", "AD_ATDCRM", "ID = {ID} AND SEQ = {SEQ}");

if ($sql.next()) {
    java.sql.Timestamp dhInc = $sql.getTimestamp("DH_INC");
    String CODPARCAtual = $sql.getString("CODPARC");

    // Obtém a data atual sem hora
    java.util.Calendar calHoje = java.util.Calendar.getInstance();
    calHoje.set(java.util.Calendar.HOUR_OF_DAY, 0);
    calHoje.set(java.util.Calendar.MINUTE, 0);
    calHoje.set(java.util.Calendar.SECOND, 0);
    calHoje.set(java.util.Calendar.MILLISECOND, 0);

    java.util.Calendar calInc = java.util.Calendar.getInstance();
    calInc.setTime(dhInc);
    calInc.set(java.util.Calendar.HOUR_OF_DAY, 0);
    calInc.set(java.util.Calendar.MINUTE, 0);
    calInc.set(java.util.Calendar.SECOND, 0);
    calInc.set(java.util.Calendar.MILLISECOND, 0);

    // Se a data de inclusão for diferente da data atual, bloqueia a alteração
    if (!calHoje.equals(calInc)) {
        throw new IllegalArgumentException("Alteração apenas dentro do Dia.");
    } else {
        return $valorCampo; // Pode alterar normalmente
    }
} else {
    // Caso não encontre o registro
    return $valorCampo;
}

return $valorCampo;
