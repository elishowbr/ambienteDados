# Documentação Técnica: Sistema de Gestão de Hotelaria e Reservas

## 1. INTRODUÇÃO E ESCOPO DO SISTEMA

O Sistema de Gestão de Hotelaria e Reservas foi projetado arquiteturalmente para sustentar as operações críticas de ponta a ponta de um hotel de grande porte (infraestrutura superior a 200 quartos). Este ecossistema lida com uma malha de dados transacional dinâmica e altamente interconectada, acomodando desde o cadastro meticuloso de hóspedes nacionais e internacionais até o gerenciamento minucioso de inventário, estadias, faturamento e manutenção.

Os macroprocessos de negócio suportados por esta base de dados incluem:
*   **Gestão de Acomodações e Capacidade:** Controle absoluto do ciclo de vida das reservas, alocação inteligente baseada em categorias físicas, validação de ocupação máxima e tarifação de preços-base.
*   **Controle de Receitas e Consumos (Billing):** Rastreabilidade transacional de serviços adicionais (restaurante, spa, lavanderia) vinculados a cada estadia, garantindo apuração precisa da receita e auditoria do funcionário operador.
*   **Gestão Predial (Facilities):** Previsibilidade e histórico de indisponibilidade de unidades (quartos), controlando custos, janelas de SLA (Service Level Agreement) para reparos e equipes técnicas responsáveis.
*   **Inteligência Gerencial (BI):** Estrutura otimizada para extração analítica, permitindo a geração em tempo real de métricas como taxa de ocupação, ticket médio por hóspede e rentabilidade de setores de serviço.

---

## 2. DICIONÁRIO DE DADOS COMPLETO

### 2.1. `categoria_quarto`
**Finalidade:** Catálogo mestre dos tipos de acomodações, definindo regras globais de precificação e engenharia da planta.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_categoria` | INT | PK | Identificador exclusivo da categoria. |
| `nome` | VARCHAR(50) | NOT NULL | Nomenclatura comercial (Ex: Suíte Master). |
| `metragem` | DECIMAL(5,2) | - | Área total do ambiente em metros quadrados. |
| `qtd_camas` | INT | - | Quantidade de leitos disponíveis no padrão. |
| `capacidade_maxima` | INT | - | Lotação máxima permitida por questões de segurança. |
| `preco_base_diaria` | DECIMAL(10,2) | NOT NULL | Valor padrão cobrado por pernoite. |

### 2.2. `comodidade`
**Finalidade:** Repositório atômico de facilidades, amenidades e itens de conforto.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_comodidade` | INT | PK | Identificador único do item de conforto. |
| `descricao` | VARCHAR(100) | NOT NULL | Descrição do item (Ex: Jacuzzi, Ar-condicionado). |

### 2.3. `categoria_comodidade`
**Finalidade:** Tabela associativa resolvendo o relacionamento N:M entre Categorias e Comodidades.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_categoria_comodidade` | INT | PK | Chave substituta (surrogate key) do registro. |
| `id_categoria` | INT | FK, NOT NULL | Referência à categoria do quarto. |
| `id_comodidade` | INT | FK, NOT NULL | Referência à comodidade oferecida. |

### 2.4. `quarto`
**Finalidade:** Representação física de cada unidade habitacional individual do hotel.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_quarto` | INT | PK | Identificador sistêmico do espaço físico. |
| `id_categoria` | INT | FK, NOT NULL | Relacionamento lógico com as regras da categoria. |
| `numero_quarto` | VARCHAR(10) | NOT NULL | Numeração da porta. |
| `andar` | VARCHAR(10) | - | Pavimento de localização. |
| `status` | VARCHAR(20) | NOT NULL | Situação rotativa (disponível, ocupado, manutenção). |

### 2.5. `hospede`
**Finalidade:** Entidade central de CRM (Customer Relationship Management) e faturamento.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_hospede` | INT | PK | Identificador exclusivo do cliente. |
| `nome_completo` | VARCHAR(150) | NOT NULL | Nome civil completo do hóspede. |
| `cpf_passaporte` | VARCHAR(50) | NOT NULL | Documento primário de identificação legal e fiscal. |
| `telefone` | VARCHAR(20) | - | Contato de acionamento imediato. |
| `email` | VARCHAR(100) | - | Canal de comunicação formal e envio de notas. |
| `logradouro` a `cep`| VARCHAR | - | Componentes geográficos fragmentados (1FN). |
| `nacionalidade` | VARCHAR(50) | - | Origem demográfica do cliente. |

### 2.6. `reserva`
**Finalidade:** Núcleo transacional do sistema; o contrato jurídico que amarra Tempo, Espaço e Cliente.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_reserva` | INT | PK | Identificador global do contrato de hospedagem. |
| `id_hospede` | INT | FK, NOT NULL | Referência ao locatário/responsável legal. |
| `id_quarto` | INT | FK, NOT NULL | Referência ao inventário físico bloqueado. |
| `data_checkin` | DATE | NOT NULL | Início contratual da estadia. |
| `data_checkout` | DATE | NOT NULL | Previsão ou efetivação do fim da estadia. |
| `qtd_hospedes` | INT | NOT NULL | Volume real de passantes para verificação de limites. |
| `valor_total` | DECIMAL(10,2) | - | Acumulador de custo global previsto das diárias. |
| `forma_pagamento` | VARCHAR(50) | - | Via de quitação da dívida central. |
| `status` | VARCHAR(30) | NOT NULL | Maquina de estados (pendente, confirmada, concluída). |
| `solicitacoes_especiais` | TEXT | - | Requisições arbitrárias de customização da estadia. |

### 2.7. `funcionario`
**Finalidade:** Gestão operacional do capital humano para fins de rastreabilidade e auditoria.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_funcionario` | INT | PK | Identificador do colaborador no RH. |
| `nome_completo` | VARCHAR(150) | NOT NULL | Nome de registro do funcionário. |
| `funcao` | VARCHAR(50) | NOT NULL | Cargo orgânico (Gerente, Manutenção, etc). |
| `escala_trabalho` | VARCHAR(50) | - | Jornada horária e dias de trabalho. |

### 2.8. `servico_adicional`
**Finalidade:** Tabela-catálogo de precificação estática para serviços opcionais do hotel.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_servico` | INT | PK | Identificador do produto interno. |
| `nome_servico` | VARCHAR(100) | NOT NULL | Nomenclatura de prateleira (Ex: Transfer VIP). |
| `valor_padrao` | DECIMAL(10,2) | NOT NULL | Ponto de partida monetário para cobranças. |

### 2.9. `consumo_servico`
**Finalidade:** Entidade de Fato; registra de forma imutável a ação de compra durante a estadia.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_consumo` | INT | PK | Identificador fiscal da transação pontual. |
| `id_reserva` | INT | FK, NOT NULL | Conta destino onde o consumo será faturado. |
| `id_servico` | INT | FK, NOT NULL | Produto ou facilidade entregue. |
| `id_funcionario` | INT | FK, NOT NULL | Colaborador que sancionou e entregou o pedido. |
| `data_hora` | TIMESTAMP | NOT NULL | Marcação temporal exata do fato gerador. |
| `valor_cobrado` | DECIMAL(10,2) | NOT NULL | Montante efetivamente acordado na hora do consumo. |
| `tipo_cobranca` | VARCHAR(30) | NOT NULL | Flag contábil (imediata ou faturada no checkout). |

### 2.10. `manutencao`
**Finalidade:** Auditoria de facilities, bloqueando o faturamento do quarto e calculando custos operativos.
| Nome da Coluna | Tipo de Dados | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `id_manutencao` | INT | PK | OS (Ordem de Serviço) gerada para o técnico. |
| `id_quarto` | INT | FK, NOT NULL | Ativo que sofreu a intervenção. |
| `id_funcionario` | INT | FK, NOT NULL | Técnico responsável pela execução/laudo. |
| `tipo_manutencao` | VARCHAR(50) | NOT NULL | Categoria contábil da OS (Preventiva, Corretiva). |
| `data_inicio` | TIMESTAMP | NOT NULL | Acionamento do trigger de indisponibilidade sistêmica. |
| `data_fim` | TIMESTAMP | - | Finalização comprovada da intervenção. |
| `previsao_liberacao` | TIMESTAMP | - | Estimativa (SLA) para a recepção revender o quarto. |
| `custo` | DECIMAL(10,2) | - | Custo agregado de peças/materiais utilizados. |
| `descricao` | TEXT | - | Parecer técnico e narrativo do defeito/resolução. |

---

## 3. ANÁLISE DE NORMALIZAÇÃO (RUMO À 3ª FORMA NORMAL)

O processo de modelagem seguiu premissas científicas da teoria relacional, alcançando a 3ª Forma Normal (3FN) para blindar o banco de dados contra anomalias de Inserção, Atualização e Exclusão.

### Primeira Forma Normal (1FN): Atomicidade
**Conceito:** Eliminação de grupos repetitivos e atributos multivalorados. Todas as colunas devem conter apenas valores atômicos e indivisíveis.
**Aplicação Prática no Sistema:** 
*   Em vez de armazenar o `endereco` do Hóspede em um único campo de texto longo que exigiria varreduras `LIKE` pesadas para buscar todos os paulistas, a estrutura foi fragmentada em `logradouro`, `numero`, `bairro`, `cidade`, `estado`, `pais` e `cep`.
*   A característica de **Comodidades** foi o ponto crucial. Em um modelo não normalizado (0FN), a tabela de Categorias teria um atributo `comodidades = "ar-condicionado, tv, jacuzzi"`. Isso inviabiliza relatórios quantitativos e corrompe a atomicidade. Ao extrairmos para a entidade autônoma `comodidade` e conectarmos através de uma relação N:M (`categoria_comodidade`), resolvemos a 1FN por completo.

### Segunda Forma Normal (2FN): Dependência Funcional Total
**Conceito:** Atende a 1FN e exige que todos os atributos não-chave dependam *totalmente* da chave primária inteira (especialmente em chaves compostas/associativas), e não apenas de parte dela.
**Aplicação Prática no Sistema:**
*   A tabela fato `consumo_servico` é essencialmente uma materialização da relação N:M entre `reserva` e `servico_adicional`. O `valor_cobrado` não depende apenas do serviço e nem apenas da reserva; ele depende da transação exata (quem consumiu o quê, no momento X). Tudo orbita ao redor da PK `id_consumo`, eliminando ambiguidades e dependências parciais estruturais.

### Terceira Forma Normal (3FN): Sem Dependências Transitivas
**Conceito:** Atende a 2FN e exige que nenhum atributo não-chave dependa funcionalmente de outro atributo não-chave (A depende de B, que depende da PK). O foco é erradicar dependências transitivas.
**Aplicação Prática no Sistema:**
*   **Isolamento da Categoria:** A tabela `quarto` possui a PK `id_quarto`. Se `capacidade_maxima` ou `preco_base_diaria` estivessem em `quarto`, elas sofreriam dependência transitiva, pois seu valor é inteiramente ditado por pertencer a um determinado tipo/categoria (`id_categoria`), e não ao número da porta em si. Isso geraria uma Anomalia de Atualização: para alterar o preço do tipo "Standard", o DBA precisaria atualizar `UPDATE quarto SET preco...` em 80 registros diferentes simultaneamente. Separando a tabela `categoria_quarto`, alteramos o preço em 1 registro e propagamos analiticamente para toda a rede.

---

## 4. ARQUITETURA DE DESEMPENHO E INTEGRIDADE

A escrita do script DDL obedeceu às diretrizes de Engenharia de Dados corporativa, especialmente em ambientes OLTP (Online Transaction Processing).

### Separação de Criação de Tabelas vs. Foreign Keys (ALTER TABLE)
1. **Quebra de Referência Circular (Deadlocks de Compilação):** Se tentarmos criar tabelas com restrições FK *inline* (direto no CREATE TABLE), a ordem exata do script se torna insustentável caso a Tabela A referencie a B, e a B referencie a A. Criar todas as entidades sem conexões primeiro garante sucesso imediato no parser.
2. **Modularidade em Cargas Massivas (Bulk Loading):** Durante a migração noturna ou carga de legados, o SGBD gasta ciclos de CPU exorbitantes validando regras de integridade referencial a cada `INSERT`. Separar em `ALTER TABLE` permite ao DBA adotar a estratégia de desativar (drop) as FKs, despejar milhões de registros em paralelo com alta taxa de I/O, e restabelecer (add constraint) a validação num único pulso no final do processo.

### Criação Explícita de Índices B-Tree (CREATE INDEX) nas FKs
1. **Prevenção de I/O Asphyxia (Seq Scans):** SGBDs não criam índices automáticos em chaves estrangeiras (apenas em Primárias e Unique). Ao executar relatórios pesados (como descobrir a receita mensal juntando `consumo_servico` com `reserva`), sem índices, o SGBD é forçado a realizar um *Sequential Scan* (ler o disco linha por linha). O comando `CREATE INDEX idx_consumo_reserva` cria uma árvore B otimizada que reduz o tempo de busca de $O(N)$ para $O(\log N)$.
2. **Optimizer Steering:** A malha de índices instrui o Query Planner do motor de banco de dados a usar algoritmos eficientes (Nested Loop Index Joins ou Hash Joins) em vez de varreduras cartesianas, vital para manter os relatórios de Diretoria executando em sub-segundos, independentemente de haver 1.000 ou 1.000.000 de registros.

---

## 5. PLANO DE TESTES E VALIDAÇÃO (PASSO A PASSO)

### 5.1. Teste de Restrição de Integridade (DML Inválido)
Para provar que as amarras lógicas do SGBD estão perfeitamente blindadas, o Arquiteto de Software tenta forçar uma inconsistência referencial (Exemplo: Tentar cobrar o consumo de um frigobar em uma reserva que não existe).

```sql
-- Script malicioso/inconsistente DML: 
-- ID de reserva '9999' não foi catalogado no sistema.
INSERT INTO consumo_servico (id_consumo, id_reserva, id_servico, id_funcionario, data_hora, valor_cobrado, tipo_cobranca) 
VALUES (999, 9999, 3, 1, CURRENT_TIMESTAMP, 15.00, 'imediata');
```
**Resultado Esperado do Motor do Banco:** O SGBD impedirá a transação e emitirá o erro contundente: `ERROR: insert or update on table "consumo_servico" violates foreign key constraint "fk_consumo_reserva"`. A integridade ACID (Atomicidade, Consistência, Isolamento e Durabilidade) permanece invicta.

### 5.2. Validação Lógica dos Relatórios Gerenciais
Os scripts da Etapa 5 foram engenheirados para demonstrar precisão matemática e consolidação:

*   **Relatório 1 (Ocupação %):** Usa-se um recurso de Subquery escalonada no `SELECT` (`SELECT COUNT(*) FROM quarto WHERE...`) associado ao `GROUP BY` principal. A fórmula `(Dias Ocupados * 100) / (Quartos Totais da Categoria * 30)` infere que o denominador representa a matriz teórica máxima de vendas do mês. Se temos 2 quartos Standard e eles ficaram ocupados 6 dias somados, a conta prova que houve `6 * 100 / (2 * 30) = 10%` de ocupação efetiva na categoria.
*   **Relatório 2 (Consumo por Hóspede):** Um triplo `JOIN` (`hospede` -> `reserva` -> `consumo_servico`). Usar a função de agregação `SUM(cs.valor_cobrado)` com agrupamento (`GROUP BY`) pelo nome do cliente consolida todos os micro-tickets (cada latinha do frigobar ou prato do restaurante) em um perfil totalizado de faturamento LTV (Lifetime Value) por viagem.
*   **Relatório 3 (Receita Mensal de Serviços):** Extratificação baseada em funções de formatação de data (`TO_CHAR(data_hora, 'YYYY-MM')`). O banco atua como mecanismo de BI OLAP primitivo agregando receitas (`SUM`) independentemente das reservas, focando puramente no desempenho da unidade de negócio (Ex: o Restaurante foi mais lucrativo no mês que o Spa).
*   **Relatório 4 (Manutenções Ativas):** Mapeamento puramente horizontal de inventário indisponível. Cruza-se o Quarto com a Ordem de Manutenção, sendo de vital importância a exibição do `funcionario_responsavel`. A ausência de filtros temporais no DQL gerado cria um log forense e de auditoria decrescente de todo o passivo de intervenções técnicas (via `ORDER BY data_inicio DESC`).
