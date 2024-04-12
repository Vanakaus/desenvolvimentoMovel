import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class LeAtividadeUseCase{
    async execute(id: number): Promise<Object>{
        
        const atividade = await prisma.atividade.findUnique({
            where: {
                id: id
            },
            select: {
                id: true,
                titulo: true,
                descricao: true,
                data: true
            }
        });

        
        if(!atividade){
            console.log('Atividade não encontrada');
            throw new AppError('Atividade não encontrada');
        }

        console.log("Atividade encontrada:");
        console.log(atividade);


        return atividade;
    }
}