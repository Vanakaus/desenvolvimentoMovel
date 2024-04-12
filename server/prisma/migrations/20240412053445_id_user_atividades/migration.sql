/*
  Warnings:

  - You are about to drop the column `data` on the `atividade` table. All the data in the column will be lost.
  - You are about to drop the column `data` on the `userAtividades` table. All the data in the column will be lost.
  - Added the required column `id` to the `userAtividades` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_atividade" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "dataLimite" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_atividade" ("descricao", "id", "titulo") SELECT "descricao", "id", "titulo" FROM "atividade";
DROP TABLE "atividade";
ALTER TABLE "new_atividade" RENAME TO "atividade";
CREATE TABLE "new_userAtividades" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "id_aluno" INTEGER NOT NULL,
    "id_atividade" INTEGER NOT NULL,
    "dataEntrega" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nota" DECIMAL NOT NULL DEFAULT -1,
    CONSTRAINT "userAtividades_id_aluno_fkey" FOREIGN KEY ("id_aluno") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "userAtividades_id_aluno_fkey" FOREIGN KEY ("id_aluno") REFERENCES "atividade" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_userAtividades" ("id_aluno", "id_atividade", "nota") SELECT "id_aluno", "id_atividade", "nota" FROM "userAtividades";
DROP TABLE "userAtividades";
ALTER TABLE "new_userAtividades" RENAME TO "userAtividades";
CREATE UNIQUE INDEX "userAtividades_id_aluno_key" ON "userAtividades"("id_aluno");
CREATE UNIQUE INDEX "userAtividades_id_atividade_key" ON "userAtividades"("id_atividade");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
