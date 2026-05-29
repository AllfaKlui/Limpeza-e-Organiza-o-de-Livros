# 📚 O Organizador de Bibliotecas Universal (V5.0)
*Desenvolvido no "laboratório": Com a AI Gemini* 🧪⚡

Você tem uma pasta lotada de PDFs, Epubs e Mobis com nomes sujos, cheios de rastros de sites de download (como z-library, Anna's Archive) e caracteres estranhos? Este script em PowerShell foi criado para purificar a sua biblioteca de forma automática!

O **Organizador Universal V5.0** faz duas coisas principais:

1. Cria uma fundação de pastas (Coleções) para você organizar seus arquivos posteriormente.
2. Varre todos os arquivos soltos na pasta raiz e usa Expressões Regulares (Regex) para limpar os nomes, deixando apenas o título do livro.

## 🚀 Funcionalidades

- **Limpeza Profunda:** Remove `_`, tags como `(z-library)` e apaga tudo o que vier após `--` (geralmente lixo de formatação de sites).
- **Escudo Anti-Erros:** Filtra e destrói caracteres especiais que o Windows proíbe (`< > : " / \ | ? *`), evitando travamentos no processo.
- **Idempotente:** Pode rodar o script quantas vezes quiser. Ele só renomeia o que precisa ser renomeado.
- **Personalizável:** Você define os nomes das pastas base diretamente no código.

## 🛠️ Como usar este experimento

### Passo 1: Preparação

Para sua segurança, faça o teste primeiro! Crie uma pasta de testes no seu computador (ex: `C:\TesteLivros`) e copie alguns livros para lá.

### Passo 2: Configurando o Script

1. Baixe ou copie o arquivo `OrganizadorUniversalV5.ps1`.
2. Abra o arquivo com o **Bloco de Notas** ou o **PowerShell ISE** (pesquise no menu Iniciar do Windows).
3. Na linha `$caminhoOrigem = ...`, substitua pelo caminho da sua pasta de livros:
   ```powershell
   $caminhoOrigem = "C:\TesteLivros"
Na lista $listaDeColecoes, você pode alterar, adicionar ou remover os nomes das pastas que deseja que o script crie automaticamente para você:

PowerShell
$listaDeColecoes = @(
    "Coleção Riqueza", 
    "Coleção Ficção", 
    # Adicione as suas aqui!
)

### Passo 3: Execução

Abra o PowerShell no seu Windows.

Navegue até a pasta onde você salvou o script ou simplesmente execute-o pelo PowerShell ISE apertando a tecla F5 (botão de Play).

Assista à mágica acontecer! O script criará as pastas e limpará os nomes dos arquivos soltos para você arrastá-los manualmente para onde preferir.

# ⚠️ Possíveis Erros (A Maldição dos 260 Caracteres)

Se algum livro não for renomeado e o PowerShell exibir um erro vermelho informando PathTooLongException, significa que o caminho original do arquivo excedeu o limite histórico de 260 caracteres do Windows. Para resolver isso, mova os arquivos problemáticos para um caminho mais curto (ex: C:\Temp), rode o script lá, e depois devolva-os para a sua biblioteca!

