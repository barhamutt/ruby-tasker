require 'json'

ARQUIVO = 'task.json'

def carregar_tarefas
    File.exist?(ARQUIVO) ? JSON.parse(File.read(ARQUIVO)) : []
end

def salvar_tarefas(tarefas)
    File.write(ARQUIVO, JSON.pretty_generate(tarefas))
end

def listar_tarefas(tarefas)
    puts "\n Lista de Tarefas:"
    tarefas.each_with_index do |tarefa, i|
        status = tarefa["concluida"] ? "OK" : "TO_DO"
        puts "#{i + 1}. #{status} #{tarefa["descricao"]}"
    end
end

def adicionar_tarefa(tarefas)
    print "Digite a descrição da tarefa: "
    descricao = gets.chomp
    tarefas << { "descricao" => descricao, "concluida" => false }
end

def concluir_tarefa(tarefas)
    listar_tarefas(tarefas)
    print "Número de tarefas a concluir: "
    i = gets.to_i - 1
    tarefas[i]["concluida"] = true if tarefas[i]
end

def remover_tarefa(tarefas)
    listar_tarefas(tarefas)
    print "Número de tarefas a remover: "
    i = gets.to_i - 1
    tarefas.delete_at(i) if tarefas[i]
end

tarefas = carregar_tarefas

loop do
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
