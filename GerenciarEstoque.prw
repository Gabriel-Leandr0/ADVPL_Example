User Function GerenciarEstoque(codigoProduto, quantidadeMovimento, tipoMovimento)
    Local saldoAtual := 0

    // Consulte o saldo atual do produto no banco de dados ou em outra fonte de dados.
    DbSelectArea("PRODUTO")
    DbSeek(codigoProduto)
    If !Eof()
        saldoAtual := PRODUTO->SALDO
    EndIf
    DbCloseArea()

    // Atualize o saldo de acordo com o tipo de movimento (entrada ou saída).
    If tipoMovimento == "ENTRADA"
        saldoAtual := saldoAtual + quantidadeMovimento
    Else If tipoMovimento == "SAIDA"
        If saldoAtual >= quantidadeMovimento
            saldoAtual := saldoAtual - quantidadeMovimento
        Else
            Return "Estoque insuficiente para a saída."
        EndIf
    EndIf

    // Atualize o banco de dados com o novo saldo.
    DbSelectArea("PRODUTO")
    DbSeek(codigoProduto)
    If !Eof()
        PRODUTO->SALDO := saldoAtual
        DbReplace()
    Else
        // Se o produto não existir, insira um novo registro.
        PRODUTO->CODIGO := codigoProduto
        PRODUTO->SALDO := saldoAtual
        DbAppend()
    EndIf
    DbCloseArea()

    Return "Movimento de estoque registrado com sucesso. Saldo atual: " + Str(saldoAtual)
