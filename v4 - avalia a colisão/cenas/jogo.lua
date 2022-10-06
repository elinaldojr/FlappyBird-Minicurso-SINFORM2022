Jogo = Classe:extend()

function Jogo:new()
   passaro = Passaro()

   tabelaCanos = {}
   tempoCanos = 1
end

function Jogo:update(dt)
   passaro:update(dt)
   
   tempoCanos = tempoCanos - dt -- atualiza tempo dos canos
   if tempoCanos <= 0 then
      local cano = Cano()

      table.insert(tabelaCanos, cano)
      tempoCanos = 1.5
   end

  --percorre tabela de canos
   for i=#tabelaCanos, 1, -1 do
      tabelaCanos[i]:update(dt)

      if verificaColisao(passaro, tabelaCanos[i]) then
         som_bateu:play()
         som_perdeu:play()
         cenaAtual = "fimDeJogo"
     end
     
      if tabelaCanos[i]:saiuDaTela() then
         som_ponto:play()
         table.remove(tabelaCanos, i) 
      end
   end
end

function Jogo:draw()
   for i, cano in pairs(tabelaCanos) do
      cano:draw()
   end

   passaro:draw()
end

--Colisão AABB especial por conta dos canos rotacionados
function verificaColisao(A, B) 
   if A.x < B.xSup and
   A.x + A.largura > B.xSup - B.largura and
   A.y < B.ySup and --A.y < B.ySup + B.altura - B.altura
   A.y + A.altura > B.ySup - B.altura then -- A.y + A.altura > B.ySup
      return true
   elseif A.x < B.xInf + B.largura and
   A.x + A.largura > B.xInf and
   A.y < B.yInf + B.altura and
   A.y + A.altura > B.yInf then
      return true
   end
end