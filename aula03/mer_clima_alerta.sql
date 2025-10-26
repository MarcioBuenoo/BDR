    estado {
        CHAR(2) sigla_estado PK
        VARCHAR nome_estado
    }

    localizacao {
        INT id_localizacao PK
        NUMERIC latitude
        NUMERIC longitude
        VARCHAR cidade
        CHAR(2) sigla_estado FK
    }

    tipo_evento {
        INT id_tipo_evento PK
        VARCHAR nome
        TEXT descricao
    }

    usuario {
        INT id_usuario PK
        VARCHAR nome
        VARCHAR email
        VARCHAR senha_hash
    }

    telefone {
        INT id_telefone PK
        VARCHAR numero
        INT id_usuario FK
    }

    evento {
        INT id_evento PK
        VARCHAR titulo
        TEXT descricao
        TIMESTAMP data_hora
        VARCHAR status
        INT id_tipo_evento FK
        INT id_localizacao FK
    }

    relato {
        INT id_relato PK
        TEXT texto
        TIMESTAMP data_hora
        INT id_evento FK
        INT id_usuario FK
    }

    alerta {
        INT id_alerta PK
        TEXT mensagem
        TIMESTAMP data_hora
        VARCHAR nivel
        INT id_evento FK
    }

    historico_evento {
        INT id_historico PK
        VARCHAR status_anterior
        VARCHAR status_novo
        TIMESTAMP data_modificacao
        INT id_evento FK
        INT modificado_por_usuario_id FK
    }