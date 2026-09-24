/* ============================================================
   Meu Perfil — Biblioteca (protótipo visual)
   Dados fixos em memória, apenas para demonstrar a interface.
   NÃO há conexão com o PostgreSQL — os números abaixo espelham
   o que os scripts 07 a 11 da pasta scripts/ calculariam para
   este mesmo conjunto de leitores/empréstimos de exemplo.
   ============================================================ */

const NIVEIS = [
  { numero: 1, nome: "Leitor Iniciante", pontosMinimos: 0 },
  { numero: 2, nome: "Leitor Frequente", pontosMinimos: 30 },
  { numero: 3, nome: "Leitor Assíduo", pontosMinimos: 60 },
  { numero: 4, nome: "Leitor Dedicado", pontosMinimos: 90 },
  { numero: 5, nome: "Leitor Expert", pontosMinimos: 120 },
];

const CATALOGO_CONQUISTAS = [
  { codigo: "PRIMEIRO_EMPRESTIMO", nome: "Primeiro Empréstimo", descricao: "Realizou o primeiro empréstimo na biblioteca." },
  { codigo: "PRIMEIRA_DEVOLUCAO", nome: "Primeira Devolução", descricao: "Devolveu um livro dentro do prazo pela primeira vez." },
  { codigo: "LEITOR_FREQUENTE", nome: "Leitor Frequente", descricao: "Atingiu o nível Leitor Frequente." },
  { codigo: "CINCO_LIVROS", nome: "5 Livros Lidos", descricao: "Concluiu 5 empréstimos com devolução registrada." },
  { codigo: "DEZ_LIVROS", nome: "10 Livros Lidos", descricao: "Concluiu 10 empréstimos com devolução registrada." },
  { codigo: "EXPLORADOR_CATEGORIAS", nome: "Explorador de Categorias", descricao: "Pegou livros emprestados de 3 categorias diferentes." },
];

const LEITORES = [
  {
    id: 1,
    numeroCartao: "0001",
    nome: "João Silva",
    membroDesde: "01/09/2026",
    emprestimos: 4,
    devolucoesNoPrazo: 2,
    categorias: 3,
    conquistasDesbloqueadas: ["PRIMEIRO_EMPRESTIMO", "PRIMEIRA_DEVOLUCAO", "LEITOR_FREQUENTE", "EXPLORADOR_CATEGORIAS"],
    historico: [
      { data: "01/08/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "10/08/2026", motivo: "Devolução no prazo", pontos: 20 },
      { data: "15/08/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "01/09/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "05/09/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "07/09/2026", motivo: "Devolução no prazo", pontos: 20 },
      { data: "23/09/2026", motivo: "Bônus conquista: Explorador de Categorias", pontos: 15 },
    ],
  },
  {
    id: 2,
    numeroCartao: "0002",
    nome: "Maria Souza",
    membroDesde: "02/09/2026",
    emprestimos: 5,
    devolucoesNoPrazo: 5,
    categorias: 3,
    conquistasDesbloqueadas: ["PRIMEIRO_EMPRESTIMO", "PRIMEIRA_DEVOLUCAO", "LEITOR_FREQUENTE", "CINCO_LIVROS", "EXPLORADOR_CATEGORIAS"],
    historico: [
      { data: "05/08/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "06/08/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "10/08/2026", motivo: "Devolução no prazo", pontos: 20 },
      { data: "14/08/2026", motivo: "Devolução no prazo", pontos: 20 },
      { data: "20/08/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "29/08/2026", motivo: "Devolução no prazo", pontos: 20 },
      { data: "02/09/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "09/09/2026", motivo: "Devolução no prazo", pontos: 20 },
      { data: "10/09/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "18/09/2026", motivo: "Devolução no prazo", pontos: 20 },
      { data: "23/09/2026", motivo: "Bônus conquista: 5 Livros Lidos", pontos: 25 },
      { data: "23/09/2026", motivo: "Bônus conquista: Explorador de Categorias", pontos: 15 },
    ],
  },
  {
    id: 3,
    numeroCartao: "0003",
    nome: "Ana Oliveira",
    membroDesde: "04/09/2026",
    emprestimos: 2,
    devolucoesNoPrazo: 1,
    categorias: 2,
    conquistasDesbloqueadas: ["PRIMEIRO_EMPRESTIMO", "PRIMEIRA_DEVOLUCAO", "LEITOR_FREQUENTE"],
    historico: [
      { data: "01/09/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "10/09/2026", motivo: "Empréstimo realizado", pontos: 10 },
      { data: "19/09/2026", motivo: "Devolução no prazo", pontos: 20 },
    ],
  },
];

function totalPontos(leitor) {
  return leitor.historico.reduce((soma, item) => soma + item.pontos, 0);
}

function nivelAtual(pontos) {
  let atual = NIVEIS[0];
  for (const n of NIVEIS) {
    if (pontos >= n.pontosMinimos) atual = n;
  }
  return atual;
}

function proximoNivel(pontos) {
  return NIVEIS.find((n) => n.pontosMinimos > pontos) || null;
}

function iniciais(nome) {
  return nome.split(" ").filter(Boolean).slice(0, 2).map((p) => p[0]).join("").toUpperCase();
}

function preencherSeletor() {
  const select = document.getElementById("leitor-select");
  select.innerHTML = "";
  LEITORES.forEach((leitor) => {
    const opt = document.createElement("option");
    opt.value = leitor.id;
    opt.textContent = leitor.nome;
    select.appendChild(opt);
  });
}

function renderPerfil(leitor) {
  const pontos = totalPontos(leitor);
  const atual = nivelAtual(pontos);
  const proximo = proximoNivel(pontos);

  document.getElementById("avatar").textContent = iniciais(leitor.nome);
  document.getElementById("numero-cartao").textContent = leitor.numeroCartao;
  document.getElementById("nome-leitor").textContent = leitor.nome.split(" ")[0];
  document.getElementById("membro-desde").textContent = leitor.membroDesde;

  document.getElementById("nivel-numero").textContent = atual.numero;
  document.getElementById("nivel-nome").textContent = atual.nome;
  document.getElementById("pontos-total").textContent = pontos;

  const faixaAtual = pontos - atual.pontosMinimos;
  const faixaTotal = proximo ? proximo.pontosMinimos - atual.pontosMinimos : faixaAtual || 1;
  const percentual = proximo ? Math.min(100, Math.round((faixaAtual / faixaTotal) * 100)) : 100;

  const fill = document.getElementById("progresso-fill");
  fill.style.width = percentual + "%";
  fill.parentElement.parentElement.setAttribute("aria-label", `Progresso: ${percentual}% até o próximo nível`);

  const legenda = document.getElementById("progresso-legenda");
  legenda.textContent = proximo
    ? `${proximo.pontosMinimos - pontos} pontos para ${proximo.nome}`
    : "Nível máximo atingido";

  document.getElementById("stat-emprestimos").textContent = leitor.emprestimos;
  document.getElementById("stat-devolucoes").textContent = leitor.devolucoesNoPrazo;
  document.getElementById("stat-categorias").textContent = leitor.categorias;
  document.getElementById("stat-conquistas").textContent = leitor.conquistasDesbloqueadas.length;
}

function renderConquistas(leitor) {
  const lista = document.getElementById("lista-conquistas");
  lista.innerHTML = "";

  CATALOGO_CONQUISTAS.forEach((conquista) => {
    const desbloqueada = leitor.conquistasDesbloqueadas.includes(conquista.codigo);
    const li = document.createElement("li");
    li.className = "conquista";
    li.dataset.status = desbloqueada ? "desbloqueada" : "bloqueada";
    li.tabIndex = 0;
    li.title = conquista.descricao;

    li.innerHTML = `
      <span class="conquista__selo" aria-hidden="true">${desbloqueada ? "&#127942;" : "&#128274;"}</span>
      <span class="conquista__texto">
        <strong>${conquista.nome}</strong>
        <span>${conquista.descricao}</span>
      </span>
    `;

    // Simula o "desbloqueio": um pequeno destaque ao clicar numa conquista já obtida.
    li.addEventListener("click", () => {
      if (desbloqueada) {
        li.animate(
          [{ transform: "scale(1)" }, { transform: "scale(1.04)" }, { transform: "scale(1)" }],
          { duration: 260, easing: "ease-out" }
        );
      }
    });

    lista.appendChild(li);
  });
}

function renderHistorico(leitor) {
  const lista = document.getElementById("lista-historico");
  lista.innerHTML = "";
  const toggle = document.getElementById("toggle-historico");
  const LIMITE_INICIAL = 3;

  // Ordena do mais recente para o mais antigo.
  const ordenado = [...leitor.historico].reverse();

  ordenado.forEach((item, indice) => {
    const li = document.createElement("li");
    if (indice >= LIMITE_INICIAL) li.hidden = true;
    li.innerHTML = `
      <span class="h-motivo">${item.motivo}<br><span class="h-data">${item.data}</span></span>
      <span class="h-pontos">+${item.pontos}</span>
    `;
    lista.appendChild(li);
  });

  const temOcultos = ordenado.length > LIMITE_INICIAL;
  toggle.style.display = temOcultos ? "inline" : "none";
  toggle.textContent = "Ver extrato completo";
  toggle.setAttribute("aria-expanded", "false");
}

function alternarHistoricoCompleto() {
  const toggle = document.getElementById("toggle-historico");
  const itens = document.querySelectorAll("#lista-historico li");
  const expandido = toggle.getAttribute("aria-expanded") === "true";

  itens.forEach((li, indice) => {
    if (indice >= 3) li.hidden = expandido;
  });

  toggle.setAttribute("aria-expanded", String(!expandido));
  toggle.textContent = expandido ? "Ver extrato completo" : "Mostrar menos";
}

function renderRanking(leitorAtualId) {
  const corpo = document.getElementById("ranking-corpo");
  corpo.innerHTML = "";

  const classificados = LEITORES
    .map((l) => ({ leitor: l, pontos: totalPontos(l) }))
    .sort((a, b) => b.pontos - a.pontos);

  let posicao = 0;
  let pontosAnteriores = null;

  classificados.forEach((item, indice) => {
    posicao = item.pontos === pontosAnteriores ? posicao : indice + 1;
    pontosAnteriores = item.pontos;

    const tr = document.createElement("tr");
    tr.dataset.atual = String(item.leitor.id === leitorAtualId);
    tr.innerHTML = `
      <td class="ranking-posicao">${posicao}º</td>
      <td>${item.leitor.nome}</td>
      <td>${nivelAtual(item.pontos).nome}</td>
      <td>${item.pontos}</td>
    `;
    corpo.appendChild(tr);
  });
}

function renderTudo(leitorId) {
  const leitor = LEITORES.find((l) => l.id === leitorId);
  renderPerfil(leitor);
  renderConquistas(leitor);
  renderHistorico(leitor);
  renderRanking(leitorId);
}

document.addEventListener("DOMContentLoaded", () => {
  preencherSeletor();
  renderTudo(LEITORES[0].id);

  document.getElementById("leitor-select").addEventListener("change", (evento) => {
    renderTudo(Number(evento.target.value));
  });

  document.getElementById("toggle-historico").addEventListener("click", alternarHistoricoCompleto);
});
