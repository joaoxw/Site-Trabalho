-- Gamificação: associação N:N entre leitores e conquistas desbloqueadas.
CREATE TABLE IF NOT EXISTS leitor_conquistas (
    id_leitor INTEGER NOT NULL,
    id_conquista INTEGER NOT NULL,
    data_desbloqueio DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (id_leitor, id_conquista),
    CONSTRAINT fk_leitor_conquistas_leitor
        FOREIGN KEY (id_leitor)
        REFERENCES leitores(id_leitor)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_leitor_conquistas_conquista
        FOREIGN KEY (id_conquista)
        REFERENCES conquistas(id_conquista)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
