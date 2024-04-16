import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class DeletaUserUseCase{
    async execute(id: number): Promise<Object>{

        if(!id){
            throw new AppError('ID não informado', 400);
        }

        const user = await prisma.user.findUnique({
            where: {
                id: id
            },
            include: {
                userAtividades: true
            }
        });


        if(!user){
            throw new AppError('Usuário não encontrado', 404);
        }

        if(user.userAtividades.length > 0){
            throw new AppError('Usuário possui atividades entregues');
        }

        const userDeleted = await prisma.user.delete({
            where: {
                id: id
            }
        });

        console.log("Usuário deletado com sucesso");

        const response = {
            status: "success",
            message: "Usuário deletado com sucesso",
        }

        return response;
    }
}