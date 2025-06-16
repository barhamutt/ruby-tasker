require 'json' #Importação da biblioteca JSON

ARQUIVO = 'task.json' #define nome da constante

# Função para carregar tarefas do arquivo.
def carregar_tarefas
    File.exist?(ARQUIVO) ? JSON.parse(File.read(ARQUIVO)) : []
end

# Função - salva as tarefas no arquivo
def salvar_tarefas(tarefas)
    File.write(ARQUIVO, JSON.pretty_generate(tarefas))
end

# Função - exibe as tarefas no terminal com índice e status
def listar_tarefas(tarefas)
    puts "\n Lista de Tarefas:"
    tarefas.each_with_index do |tarefa, i|
        status = tarefa["concluida"] ? "OK" : "TO_DO"
        puts "#{i + 1}. #{status} #{tarefa["descricao"]}"
    end
    puts "\nPressione ENTER para continuar..."
    gets 
end

# Função - adiciona uma nova tarefa
def adicionar_tarefa(tarefas)
    print "Digite a descrição da tarefa: "
    descricao = gets.chomp
    tarefas << { "descricao" => descricao, "concluida" => false }
end

# Função - permite ao usuário marcar uma tarefa como concluída
def concluir_tarefa(tarefas)
    listar_tarefas(tarefas)
    print "Número de tarefas a concluir: "
    i = gets.to_i - 1
    tarefas[i]["concluida"] = true if tarefas[i]
end

# Função - permite ao usuário remover uma tarefa da lista
def remover_tarefa(tarefas)
    listar_tarefas(tarefas)
    print "Número de tarefas a remover: "
    i = gets.to_i - 1
    tarefas.delete_at(i) if tarefas[i]
end

# Função - limpa a tela do terminal
def limpar_tela
    system("clear") || system("cls")
end

# Início da execução do programa: carrega tarefas previamente salvas (se houver).
tarefas = carregar_tarefas

# Loop principal que exibe o menu, interpreta a opção do usuário e executa a ação
loop do
    limpar_tela
    puts "\n _______________________________________________________________ "
    puts "|                        -RUBY-TASKER-                          |"
    puts "+---------------------------------------------------------------+"
    puts "| 1. Listar | 2. Adicionar | 3. Concluir | 4. Remover | 5. Sair |"
    puts "+---------------------------------------------------------------+"
    puts "Escolha um opção: "
    opcao = gets.to_i

    case opcao
    when 1 then listar_tarefas(tarefas)
    when 2 then adicionar_tarefa(tarefas)
    when 3 then concluir_tarefa(tarefas)
    when 4 then remover_tarefa(tarefas)
    when 5
        salvar_tarefas(tarefas)
        puts "Tarefas salvas, Até logo!"
        break
        else
            puts " Opção inválida!"
        end
    end 
