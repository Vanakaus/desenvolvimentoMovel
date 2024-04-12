import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class AtualizaAtividadeUseCase{
    async execute(id: number, titulo: string, descricao: string, data: Date): Promise<object>{


        const atividade = await prisma.atividade.findUnique({
            where: {
                id: id
            }
        });

        if(!atividade){
            console.log("Atividade não encontrada");
            throw new AppError('Atividade não encontrada', 404);
        }

        id = id || atividade.id;
        titulo = titulo || atividade.titulo;
        descricao = descricao || atividade.descricao;
        data = data || atividade.data;
        

        
        const atividadeUpdated = await prisma.atividade.update({
            where: {
                id: id
            },
            data: {
                titulo: titulo,
                descricao: descricao,
                data: data
            }
        });

        console.log("Atividade Atualizada:");
        console.log(atividadeUpdated);
        
        return atividadeUpdated;
    }
}