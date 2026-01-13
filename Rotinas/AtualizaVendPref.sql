CREATE OR REPLACE PROCEDURE "ATUALIZAVENDPREF" (
       P_CODUSU NUMBER,        -- Código do usuário logado
       P_IDSESSAO VARCHAR2,    -- Identificador da execução. Serve para buscar informações dos parâmetros/campos da execução.
       P_QTDLINHAS NUMBER,     -- Informa a quantidade de registros selecionados no momento da execução.
       P_MENSAGEM OUT VARCHAR2 -- Caso seja passada uma mensagem aqui, ela será exibida como uma informação ao usuário.
) AS
       FIELD_CODPARC NUMBER;

       AFTER UPDATE OR INSERT ON TGFCAB
       FOR EACH ROW
BEGIN

IF UPDATING THEN
    INSERT INTO TGFPARC("CODVEND") VALUES (:OLD.CODVEND);

ELSE
    INSERT INTO TGFPARC("CODVEND") VALUES (:NEW.CODVEND);

END IF

END;

/