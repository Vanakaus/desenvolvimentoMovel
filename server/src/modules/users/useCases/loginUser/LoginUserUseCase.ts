import { prisma } from "../../../../prisma/client";
import { AppError } from "../../../../errors/AppErrors";

export class LoginUserUseCase{
    async execute(email: string, senha:string): Promise<Object>{
        
        const users = await prisma.user.findUnique({
            where: {
                email
            },
            select: {
                id: true,
                name: true,
                senha: true,
            }
        });

        
        if(!users){
            console.log('Email errado');
            throw new AppError('Email Errado');
        }

        if(users.senha != senha){
            console.log('Senha errada');
            throw new AppError('Senha Errada');
        }

        console.log("Login realizado com sucesso!");


        return users;
    }
}