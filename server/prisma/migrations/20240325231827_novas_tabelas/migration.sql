/*
  Warnings:

  - You are about to drop the `posts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `profiles` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "posts";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "profiles";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "atividade" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "userAtividades" (
    "id_aluno" INTEGER NOT NULL,
    "id_atividade" INTEGER NOT NULL,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nota" DECIMAL NOT NULL,
    CONSTRAINT "userAtividades_id_aluno_fkey" FOREIGN KEY ("id_aluno") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "userAtividades_id_aluno_fkey" FOREIGN KEY ("id_aluno") REFERENCES "atividade" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "userAtividades_id_aluno_key" ON "userAtividades"("id_aluno");

-- CreateIndex
CREATE UNIQUE INDEX "userAtividades_id_atividade_key" ON "userAtividades"("id_atividade");
