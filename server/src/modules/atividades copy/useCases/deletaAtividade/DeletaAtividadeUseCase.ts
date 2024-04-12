import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class DeletaUserAtividadeUseCase{
    async execute(id: number): Promise<Object>{

        const atividade = await prisma.atividade.findUnique({
            where: {
                id: id
            }
        });


        if(!atividade){
            throw new AppError('Entrega não encontrada', 404);
        }

        const atividadeDeleted = await prisma.userAtividades.delete({
            where: {
                id: id
            }
        });

        console.log("Atividade deletada com sucesso");

        const response = {
            status: "success",
            message: "Atividade deletada com sucesso",
        }

        return response;
    }
}