


 Bookstore Java EE + Docke

🛠️ Tecnologias Usadas
Table
Camada	Tecnologia
Backend	Java 8, JSF (JavaServer Faces), Hibernate/JPA
Servidor App	WildFly 26 (JBoss)
Banco de Dados	MySQL 8.0
Infraestrutura	Docker & Docker Compose
Build	Maven
Frontend	JSF + PrimeFaces (implícito)
🏗️ Arquitetura
plain
Copy
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Navegador     │────▶│  WildFly 26     │────▶│   MySQL 8.0     │
│                 │◄────│   (JSF App)     │◄────│                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        ▲                       ▲                       ▲
        │                       │                       │
        └───────────────────────┴───────────────────────┘
                          Docker Compose
📦 Pré-requisitos
Docker 20.10+
Docker Compose 2.0+
Git
Portas livres: 8080 (app), 3306 (MySQL), 9990 (WildFly Admin)


- arquivo
.env  >> senhas/secrets
bookstore.war
docker-compose.yml
Dockerfile
Setuo.sql (scirpt inicial )










📘 Instruções de Uso (Passo a Passo)

🔐 Login Inicial
Acesse: http://192.168.0.205:8080/bookstore/login.xhtml
Table
Campo	Valor
Email	user@lab.com
Senha	123456
⚠️ Pré-requisito: É obrigatório ter pelo menos 1 autor cadastrado antes de cadastrar livros!
📝 Fluxo de Cadastro
1. Cadastrar Autor (OBRIGATÓRIO PRIMEIRO)
plain
Copy
Menu → Cadastrar → Novo Autor
Table
Campo	Exemplo
Nome	Machado de Assis
Email	Machado@uol.com
→ Clique em "Gravar Autor"

2. Cadastrar Livro
plain
Copy
Menu → Livros → Novo Livro
Table
Passo	Ação
1	Preencha dados do livro (Título, ISBN, Preço, Estoque)
2	Selecione um autor no dropdown (cadastrado no passo anterior)
3	Clique em "Gravar Autor" (vincula autor ao livro)
4	Clique em "Gravar" (salva o livro definitivamente)
🎯 Dica: O botão "Gravar Autor" na tela de livro serve para vincular o autor selecionado ao livro atual, não cria novo autor.

🗄️ Script SQL de Inicialização
Crie o arquivo docker/mysql/init.sql para dados iniciais:
sql
Copy
-- =====================================================
-- KAZU DEVOPS LAB - DADOS INICIAIS
-- @mundojava5610 - Todos os direitos reservados
-- Repositório: https://github.com/victtorfreitas/livraria-IFTO
-- =====================================================

USE bookstore_db;

-- -----------------------------------------------------
-- Usuário padrão de acesso
-- -----------------------------------------------------
INSERT INTO usuario (email, senha, nome, perfil, ativo) 
VALUES 
('user@lab.com', '123456', 'Usuário Laboratório', 'ADMIN', TRUE);

-- -----------------------------------------------------
-- Autores de exemplo (obrigatório para cadastro de livros)
-- -----------------------------------------------------
INSERT INTO autor (nome, nacionalidade, data_nascimento) 
VALUES 
('Machado de Assis', 'Brasileira', '1839-06-21'),
('José de Alencar', 'Brasileira', '1829-05-01'),
('Clarice Lispector', 'Brasileira', '1920-12-10'),
('Jorge Amado', 'Brasileira', '1912-08-10'),
('Graciliano Ramos', 'Brasileira', '1892-10-27');

-- -----------------------------------------------------
-- Livros de exemplo (opcional - para demonstração)
-- -----------------------------------------------------
INSERT INTO livro (titulo, isbn, preco, estoque, autor_id) 
VALUES 
('Dom Casmurro', '978-85-359-0275-8', 45.90, 12, 1),
('O Guarani', '978-85-359-1234-5', 39.90, 8, 2),
('A Hora da Estrela', '978-85-359-0567-3', 29.90, 15, 3);

-- -----------------------------------------------------
-- Fim do script
-- -----------------------------------------------------
🐳 Atualização do Docker Compose
Adicione o volume do script SQL no docker-compose.yml:
yaml
Copy
version: '3.8'

📋 Checklist de Validação

Após subir a aplicação, verifique:
[ ] docker-compose logs wildfly → sem erros de conexão com MySQL
[ ] Acessar http://localhost:8080/bookstore → página de login aparece
[ ] Login com user@lab.com / 123456 → redireciona para dashboard
[ ] Menu Autores → lista com 5 autores pré-cadastrados
[ ] Menu Livros → 3 livros de exemplo já aparecem
[ ] Cadastrar novo livro → seleciona autor → Gravar Autor → Gravar ✓
🐛 Troubleshooting
Table
Problema	Solução
"Nenhum autor disponível"	Verificar se init.sql foi executado: docker logs bookstore-mysql
Erro ao gravar livro	Sempre clicar "Gravar Autor" antes de "Gravar"
Porta 8080 ocupada	Alterar no docker-compose.yml: 8081:8080
📚 Créditos & Licença
plain
Copy



 Aprendizados
Este projeto foi desenvolvido como laboratório prático para demonstrar:

Compilacao com aplicao java maven 

Containerização de Aplicações Legacy: Estratégia de "Lift and Shift" para modernizar aplicações Java EE legadas, encapsulando dependências em imagens Docker.

Administração de Application Servers (WildFly/JBoss).

Orquestração e IaC com Docker Compose: Provisionamento de infraestrutura como código, definindo redes isoladas, volumes persistentes e dependências entre serviços.

Database Seeding & Idempotência: Implementação de scripts de inicialização (setup.sql) para garantir ambientes de teste reprodutíveis e prontos para uso (Clean Slate).

Troubleshooting Multi-camada: Diagnóstico de falhas analisando desde o ciclo de vida do JSF no frontend até as constraints de integridade no MySQL.


Aplicação Java - Todos os direitos reservados
@mundojava5610

Repositório original: https://github.com/victtorfreitas/livraria-IFTO

Projeto: Kazu DevOps Lab (Bookstore Java/JSF)
Login: user@lab.com / 123456
Fluxo especial: Cadastrar Autor → depois Livro (com vinculação)
Repositório base: victtorfreitas/livraria-IFTO
