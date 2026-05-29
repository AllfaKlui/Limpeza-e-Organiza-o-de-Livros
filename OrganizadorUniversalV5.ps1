# =====================================================================
# O ORGANIZADOR DE BIBLIOTECAS UNIVERSAL V5.0
# Desenvolvido no laboratório: Projetos Loucos da Cabeça
# =====================================================================

# 1. CAMINHO DA PASTA: O usuário deve alterar este caminho para a pasta onde estão os livros
$caminhoOrigem = "C:\Caminho\Para\Sua\Pasta\De\Livros" 

# --- FASE 1: CONSTRUÇÃO DAS DIMENSÕES (PASTAS) ---
Write-Host "Iniciando a Fundação das Novas Dimensões (Pastas)..." -ForegroundColor Yellow

# 2. LISTA DE COLEÇÕES: Adicione, edite ou remova os nomes abaixo para criar as pastas base
$listaDeColecoes = @(
    "Coleção Riqueza", 
    "Coleção Religião", 
    "Coleção Cotidiano", 
    "Coleção outros escritores", 
    "Coleção As Grandes Ideas de Todos os Tempos", 
    "Coleção Jogos vorazes", 
    "Coleção Hqs", 
    "Coleção Harry Potter", 
    "Coleção Senhor dos Aneis", 
    "Coleção The Witch", 
    "Coleção Cursos", 
    "Coleção Games", 
    "Coleção As Cronicas de Narnia", 
    "Coleção Assassin's Creed", 
    "Coleção Percy Jackson"
)

foreach ($pasta in $listaDeColecoes) {
    $caminhoCompletoPasta = Join-Path -Path $caminhoOrigem -ChildPath $pasta
    if (-not (Test-Path -Path $caminhoCompletoPasta)) {
        New-Item -ItemType Directory -Path $caminhoCompletoPasta | Out-Null
        Write-Host "Pasta Base Criada: $pasta" -ForegroundColor Green
    }
}

# --- FASE 2: PURIFICAÇÃO DOS NOMES (COM PROTEÇÃO CONTRA ERROS) ---
Write-Host "`nIniciando o Raio Laser de Limpeza de Nomes V5..." -ForegroundColor Cyan

$arquivos = Get-ChildItem -Path $caminhoOrigem -File

foreach ($arquivo in $arquivos) {
    $nomeBase = $arquivo.BaseName
    $extensao = $arquivo.Extension
    $novoNome = $nomeBase

    # Limpeza padrão para arrancar lixos de sites de download
    $novoNome = $novoNome -replace "_", " "
    $novoNome = $novoNome -replace "(?i)\(z-library.*?\)", ""
    $novoNome = $novoNome -replace "(?i)\[z-library.*?\]", ""
    $novoNome = $novoNome -replace "(?i)1lib\.sk", ""
    $novoNome = $novoNome -replace "(?i)\[.*?\]", "" 

    # Cortar o nome a partir do primeiro "--" para remover rastros como "Anna's Archive" e ISBNs
    if ($novoNome -match "--") {
        $novoNome = ($novoNome -split "--")[0]
    }
    
    # ESCUDO PROTETOR: Remover caracteres que o Windows proíbe em nomes de arquivos!
    $novoNome = $novoNome -replace '[<>:"/\\|?*]', ''
    
    # Remover espaços duplos e aparar as pontas
    $novoNome = $novoNome -replace "\s+", " "
    $novoNome = $novoNome.Trim()
    
    # Segurança contra nomes que fiquem completamente vazios após a limpeza
    if ([string]::IsNullOrWhiteSpace($novoNome)) { $novoNome = "Livro_Desconhecido_" + (Get-Random) }

    $nomeFinal = $novoNome + $extensao

    # EXECUTAR A RENOMEAÇÃO (Apenas se o nome precisar mudar)
    if ($arquivo.Name -ne $nomeFinal) {
        $caminhoNovoArquivo = Join-Path -Path $caminhoOrigem -ChildPath $nomeFinal
        
        # Evita conflitos caso um arquivo com o mesmo nome limpo já exista
        if (Test-Path -Path $caminhoNovoArquivo) {
            $nomeFinal = $novoNome + " (" + (Get-Random -Maximum 999) + ")" + $extensao
        }

        try {
            Rename-Item -Path $arquivo.FullName -NewName $nomeFinal -Force
            Write-Host "Renomeado com sucesso: [$($arquivo.Name)] ---> [$nomeFinal]" -ForegroundColor DarkCyan
        }
        catch {
            Write-Host "Falha no laboratório: O arquivo $($arquivo.Name) resistiu. (Pode estar aberto ou exceder 260 caracteres)" -ForegroundColor Red
        }
    }
}

Write-Host "`nVarredura concluída! O laboratório está seguro e organizado." -ForegroundColor Magenta