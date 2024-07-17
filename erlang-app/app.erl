-module(app).
-export([start/0]).

start() -> 
    Pid = spawn(fun() -> receiver() end),
    sender(Pid, ["Olá!", "Como você está?", "Estou bem, e você?", "Bem também", "Chique irmão.", "Até logo!"]).

sender(_, []) -> ok; % Quando a lista de mensagens estiver vazia, terminar
sender(Pid, [Msg | Rest]) ->
    Pid ! {self(), Msg},
    timer:sleep(1000), % Espera 1 segundo antes de enviar a próxima mensagem
    sender(Pid, Rest).

receiver() ->
    receive
        {From, Message} ->
            io:format("Recebeu uma mensagem de ~p: ~p~n", [From, Message]), % Mostra a mensagem que setamos juntamente com isso
            receiver()
    after
        5000 ->
            io:format("Nenhuma mensagem recebida em 5 segundos ~n") % Após 5 segundos se mais nada for lançado, aparece essa mensagem.   
    end.    
