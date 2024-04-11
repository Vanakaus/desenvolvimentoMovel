import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class DeletaUserUseCase{
    async execute(id: number): Promise<Object>{

        const user = await prisma.user.findUnique({
            where: {
                id: id
            }
        });


        if(!user){
            console.log("Usuário não encontrado");
            throw new AppError('Usuário não encontrado', 404);
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