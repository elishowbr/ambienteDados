# Diagrama de Entidade e Relacionamento (DER)

```mermaid
erDiagram
    CATEGORIA_QUARTO ||--o{ QUARTO : "possui"
    HOSPEDE ||--o{ RESERVA : "realiza"
    QUARTO ||--o{ RESERVA : "recebe"
    QUARTO ||--o{ MANUTENCAO : "passa por"
    FUNCIONARIO ||--o{ MANUTENCAO : "responsavel_por"
    RESERVA ||--o{ CONSUMO_SERVICO : "registra"
    SERVICO_ADICIONAL ||--o{ CONSUMO_SERVICO : "oferecido_como"
    FUNCIONARIO ||--o{ CONSUMO_SERVICO : "atende"

    CATEGORIA_QUARTO {
        int id_categoria PK
        string nome
        float metragem
        int qtd_camas
        string comodidades
        int capacidade_maxima
        decimal preco_base_diaria
    }

    QUARTO {
        int id_quarto PK
        int id_categoria FK
        string numero_quarto
        string andar
        string status
    }

    HOSPEDE {
        int id_hospede PK
        string nome_completo
        string cpf_passaporte
        string telefone
        string email
        string nacionalidade
    }

    RESERVA {
        int id_reserva PK
        int id_hospede FK
        int id_quarto FK
        date data_checkin
        date data_checkout
        int qtd_hospedes
        decimal valor_total
        string forma_pagamento
        string status
        string solicitacoes_especiais
    }

    FUNCIONARIO {
        int id_funcionario PK
        string nome_completo
        string funcao
        string escala_trabalho
    }

    SERVICO_ADICIONAL {
        int id_servico PK
        string nome_servico
        decimal valor_padrao
    }

    CONSUMO_SERVICO {
        int id_consumo PK
        int id_reserva FK
        int id_servico FK
        int id_funcionario FK
        datetime data_hora
        decimal valor_cobrado
        string tipo_cobranca
    }

    MANUTENCAO {
        int id_manutencao PK
        int id_quarto FK
        int id_funcionario FK
        string tipo_manutencao
        datetime data_inicio
        datetime data_fim
        datetime previsao_liberacao
        decimal custo
    }
```
