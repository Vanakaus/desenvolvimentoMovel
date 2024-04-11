import { User } from "@prisma/client";
import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class LeUserUseCase{
    async execute(id: number): Promise<Object>{
        
        const users = await prisma.user.findUnique({
            where: {
                id: id
            },
            select: {
                id: true,
                name: true,
                email: true,
                senha: false,
                criacao: true,
                Atualizado: true
            }
        });

        
        if(!users){
            console.log('Usuário não encontrado');
            throw new AppError('Usuário não encontrado');
        }

        console.log("Usuário encontrado:");
        console.log(users);


        return users;
    }
}