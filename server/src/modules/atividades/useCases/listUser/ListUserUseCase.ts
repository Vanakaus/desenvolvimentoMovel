import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class ListUserUseCase{
    async execute(): Promise<object[]>{

        const users = await prisma.user.findMany({
            select: {
                id: true,
                name: true,
                email: true,
                criacao: true,
                Atualizado: true
            }
        });


        if(!users){
            console.log("Sem Usuários cadastrados");
            throw new AppError('Sem Usuários cadastrados');
        }

        console.log("Lista de Usuários:");
        console.log(users);
        
        return users;
    }
}