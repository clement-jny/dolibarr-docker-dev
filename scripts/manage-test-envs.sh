#!/bin/bash
set -e

# Script pour gérer les environnements de test
# Usage: ./manage-test-envs.sh <action> [args...]

ACTION=$1

case $ACTION in
    "list")
        echo "📋 Environnements de test disponibles:"
        if [ -d "test" ]; then
            for env in test/*/; do
                if [ -d "$env" ]; then
                    env_name=$(basename "$env")
                    if [ -f "$env/info.txt" ]; then
                        echo "  📁 $env_name"
                        grep "🌐\|👤" "$env/info.txt" | sed 's/^/    /'
                        echo ""
                    fi
                fi
            done
        else
            echo "  Aucun environnement de test trouvé"
        fi
        ;;
    
    "start")
        ENV_NAME=$2
        if [ -z "$ENV_NAME" ]; then
            echo "❌ Nom d'environnement manquant. Usage: ./manage-test-envs.sh start <env_name>"
            exit 1
        fi
        
        if [ ! -d "test/$ENV_NAME" ]; then
            echo "❌ Environnement $ENV_NAME introuvable"
            exit 1
        fi
        
        echo "🚀 Démarrage de l'environnement $ENV_NAME..."
        cd "test/$ENV_NAME"
        docker-compose up -d
        cd ../..
        echo "✅ Environnement $ENV_NAME démarré"
        ;;
    
    "stop")
        ENV_NAME=$2
        if [ -z "$ENV_NAME" ]; then
            echo "❌ Nom d'environnement manquant. Usage: ./manage-test-envs.sh stop <env_name>"
            exit 1
        fi
        
        if [ ! -d "test/$ENV_NAME" ]; then
            echo "❌ Environnement $ENV_NAME introuvable"
            exit 1
        fi
        
        echo "🛑 Arrêt de l'environnement $ENV_NAME..."
        cd "test/$ENV_NAME"
        docker-compose down
        cd ../..
        echo "✅ Environnement $ENV_NAME arrêté"
        ;;
    
    "remove")
        ENV_NAME=$2
        if [ -z "$ENV_NAME" ]; then
            echo "❌ Nom d'environnement manquant. Usage: ./manage-test-envs.sh remove <env_name>"
            exit 1
        fi
        
        if [ ! -d "test/$ENV_NAME" ]; then
            echo "❌ Environnement $ENV_NAME introuvable"
            exit 1
        fi
        
        echo "🗑️  Suppression de l'environnement $ENV_NAME..."
        cd "test/$ENV_NAME"
        docker-compose down -v
        cd ../..
        rm -rf "test/$ENV_NAME"
        echo "✅ Environnement $ENV_NAME supprimé"
        ;;
    
    "clean")
        echo "🧹 Nettoyage des environnements de test arrêtés..."
        docker system prune -f
        echo "✅ Nettoyage terminé"
        ;;
    
    "ports")
        echo "📊 Ports utilisés par les environnements de test:"
        if [ -d "test" ]; then
            for env in test/*/; do
                if [ -d "$env" ] && [ -f "$env/docker-compose.yml" ]; then
                    env_name=$(basename "$env")
                    ports=$(grep -E "^\s*-\s*\"[0-9]+:[0-9]+\"" "$env/docker-compose.yml" | sed 's/.*"\([0-9]*\):.*/\1/' | sort -n)
                    if [ ! -z "$ports" ]; then
                        echo "  📁 $env_name: $(echo $ports | tr '\n' ' ')"
                    fi
                fi
            done
        fi
        
        echo ""
        echo "🔍 Ports disponibles dans la plage 8000-8100:"
        used_ports=$(netstat -tln | grep -E ":80[0-9][0-9] " | sed 's/.*:\(80[0-9][0-9]\) .*/\1/' | sort -n)
        for port in {8000..8100}; do
            if ! echo "$used_ports" | grep -q "^$port$"; then
                echo -n "$port "
            fi
        done
        echo ""
        ;;
    
    *)
        echo "Usage: ./manage-test-envs.sh <action> [args...]"
        echo ""
        echo "Actions disponibles:"
        echo "  list              - Lister tous les environnements de test"
        echo "  start <env_name>  - Démarrer un environnement de test"
        echo "  stop <env_name>   - Arrêter un environnement de test"
        echo "  remove <env_name> - Supprimer un environnement de test"
        echo "  clean             - Nettoyer les ressources Docker inutilisées"
        echo "  ports             - Afficher les ports utilisés et disponibles"
        exit 1
        ;;
esac