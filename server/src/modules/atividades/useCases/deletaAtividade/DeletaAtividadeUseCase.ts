import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class DeletaAtividadeUseCase{
    async execute(id: number): Promise<Object>{

        const atividade = await prisma.atividade.findUnique({
            where: {
                id: id
            }
        });


        if(!atividade){
            console.log("Atividade não encontrada");
            throw new AppError('Atividade não encontrada', 404);
        }

        const atividadeDeleted = await prisma.atividade.delete({
            where: {
                id: id
            }
        });

        console.log("Atividade deletada:");

        const response = {
            status: "success",
            message: "Atividade deletada com sucesso",
        }

        return response;
    }
}