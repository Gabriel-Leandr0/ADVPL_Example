user function CalcularPrecoItem(nCodigoItem, nQuantidade)
   local nPrecoUnitario := 0.0

   // Consultar o banco de dados ou fonte de dados para obter o preço do item
   dbSelectArea("ITEMS")
   dbSeek(nCodigoItem)

   if !dbFound()
      return 0.0 // Item não encontrado no banco de dados
   endif

   nPrecoUnitario := ITEMS->PRECO_UNITARIO

   // Calcular o preço total
   local nPrecoTotal := nPrecoUnitario * nQuantidade

   return nPrecoTotal
