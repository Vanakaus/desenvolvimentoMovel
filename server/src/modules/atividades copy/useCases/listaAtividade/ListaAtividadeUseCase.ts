import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class ListaAtividadeUseCase{
    async execute(): Promise<object[]>{

        const atividades = await prisma.atividade.findMany({
            select: {
                id: true,
                titulo: true,
                descricao: true,
                data: true
            }
        });


        if(!atividades){
            console.log("Sem Atividades cadastradas");
            throw new AppError('Sem Atividades cadastradas');
        }

        console.log("Lista de Atividades:");
        console.log(atividades);
        
        return atividades;
    }
}