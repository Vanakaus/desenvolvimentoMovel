import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class AtualizaAtividadeEntregaUseCase{
    async execute(id: number, dataEntrega: Date): Promise<object>{


        let atividade = await prisma.userAtividades.findUnique({
            where: {
                id: id
            }
        });

        if(!atividade){
            throw new AppError('Entrega não encontrada', 404);
        }


        atividade = await prisma.userAtividades.update({
            where: {
                id: id
            },
            data: {
                dataEntrega: dataEntrega
            }
        });
        

        console.log("Entrega Atualizada:");
        console.log(atividade);
        
        return atividade;
    }
}


export class AtualizaAtividadeNotaUseCase{
    async execute(id: number, nota: number): Promise<object>{


        let atividade = await prisma.userAtividades.findUnique({
            where: {
                id: id
            }
        });

        if(!atividade){
            throw new AppError('Entrega não encontrada', 404);
        }


        atividade = await prisma.userAtividades.update({
            where: {
                id: id
            },
            data: {
                nota: nota
            }
        });
        

        console.log("Entrega Atualizada:");
        console.log(atividade);
        
        return atividade;
    }
}